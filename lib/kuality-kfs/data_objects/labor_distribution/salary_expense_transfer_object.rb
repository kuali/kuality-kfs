class SalaryExpenseTransferObject < KFSDataObject

  include Utilities
  include GlobalConfig
  include SalaryExpenseTransferAccountingLinesMixin

  DOC_INFO = { label: 'Salary Expense Transfer Document', type_code: 'ST' }

  attr_accessor :fiscal_year, :employee_id,
                :remembered_employee_id,
                # constants used for verifying LLPE entries, values in KFS Parameters table
                :actuals_balance_type, :labor_balance_type, :debit_code, :credit_code, :period_unassigned

  def defaults
    # We'll merge the default_items so that our class defaults override it
    super.merge({   employee_id:          get_aft_parameter_value(ParameterConstants::DEFAULT_ST_EMPL_ID),
                    actuals_balance_type: get_aft_parameter_value(ParameterConstants::DEFAULT_ST_ACTUALS_BALANCE_TYPE),
                    labor_balance_type:   get_aft_parameter_value(ParameterConstants::DEFAULT_ST_LABOR_BALANCE_TYPE),
                    debit_code:           get_aft_parameter_value(ParameterConstants::DEFAULT_ST_DEBIT_CODE),
                    credit_code:          get_aft_parameter_value(ParameterConstants::DEFAULT_ST_CREDIT_CODE),
                    period_unassigned:    ''
                }).merge!(default_accounting_lines)
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).salary_expense_transfer
    on SalaryExpenseTransferPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :employee_id
    end
  end

  def pull_specified_accounting_line(type, row, page)

    if type == :source
      chart_code = page.chart_code_value type, row
      account_number = page.account_number_value type, row
      sub_account_code = page.sub_account_number_value type, row
      object_code = page.object_code_value type, row
      sub_object_code = page.sub_object_code_value type, row
      project_code = page.project_code_value type, row
      organization_reference_id = page.organization_reference_id_value type, row
      position_number = page.position_number_value type, row
      payroll_end_date_fiscal_year = page.payroll_end_date_fiscal_year_value type, row
      payroll_end_date_fiscal_period_code = page.payroll_end_date_fiscal_period_code_value type, row
      payroll_total_hours = page.st_payroll_total_hours type, row
      amount = (page.st_amount type, row).gsub(/,/, '')     #remove any commas that may be present i.e. 1,234.56
      fringe_benefit_inquiry = page.view_fringe_benefit_link type, row
    else #":target"
      chart_code = page.st_chart_code type, row
      account_number = page.st_account_number type, row
      sub_account_code = page.st_sub_account_code type, row

      # Object code may or may not be editable on the page.
      # Different page objects are used depending on the page data which affects editability so try both if the first one fails.
      begin
        object_code = page.st_object_code type, row    #editable
      rescue
        object_code = page.object_code_value type, row  #non-editable
      end

      sub_object_code = page.st_sub_object_code type, row
      project_code = page.st_project_code type; row
      organization_reference_id = page.st_organization_reference_id type, row
      position_number = page.position_number_value type, row
      payroll_end_date_fiscal_year = page.payroll_end_date_fiscal_year_value type, row
      payroll_end_date_fiscal_period_code = page.payroll_end_date_fiscal_period_code_value type, row
      payroll_total_hours = page.st_payroll_total_hours type, row
      amount = (page.st_amount type, row).gsub(/,/, '')   #remove any commas that may be present i.e. 1,234.56
      fringe_benefit_inquiry = page.view_fringe_benefit_link type, row
    end

    new_line = {
        :chart_code                           => chart_code,
        :account_number                       => account_number,
        :sub_account_code                     => sub_account_code,
        :object_code                          => object_code,
        :sub_object_code                      => sub_object_code,
        :project_code                         => project_code,
        :organization_reference_id            => organization_reference_id,
        :position_number                      => position_number,
        :payroll_end_date_fiscal_year         => payroll_end_date_fiscal_year,
        :payroll_end_date_fiscal_period_code  => payroll_end_date_fiscal_period_code,
        :payroll_total_hours                  => payroll_total_hours,
        :fringe_benefit_inquiry               => fringe_benefit_inquiry,
        :amount                               => amount
    }

    return new_line
  end

  def pull_all_accounting_lines(page)
    to_lines = Array.new
    from_lines = Array.new
    #get all From lines
    for row in 0..(page.accounting_lines_row_count :source)-1
      line_hash = pull_specified_accounting_line(:source, row, page)
      from_lines.push(line_hash)
    end
    #get all To lines
    for row in 0..(page.accounting_lines_row_count :target)-1
      line_hash = pull_specified_accounting_line(:target, row, page)
      to_lines.push(line_hash)
    end

    st_accounting_lines = {
      source: from_lines,
      target: to_lines}

    return st_accounting_lines
  end


  # NOTE: percent value is stored in database as a whole number
  #       i.e. 25.00% and does not have decimal representation of .2500
  def calculate_benefit_amount(amount, percentage_as_whole_number)

    percent = percentage_as_whole_number.to_f / 100.0  #get into percent

    #to round i.e. want 10% of 22.79 ==> ((22.79 * .1)*100).round / 100.0 = 2.28
    benefit_amount = (((amount).to_f * percent.to_f) * 100.0).round / 100.0
    return benefit_amount
  end


  def llpe_line_matches_accounting_line_data(llpe_account, llpe_object, llpe_period, llpe_balance_type, llpe_amount,
      llpe_debit_credit_code, account, object, period, balance_type, amount, debit_credit_code)

    # return true only when all input parameters match;
    # period values could be zero length strings; amounts could be floats; rest should be string values
    # Note: LLPE clearing line zero dollar amounts were observed as debits when they should be credits
    #       taking this into consideration because test will fail unless both debit and credit are allowed for zero dollar amounts.
    if (llpe_account == account) && (llpe_object == object) && (llpe_balance_type == balance_type) &&
        ( (llpe_period.empty? && period.empty?) || (!llpe_period.empty? && !period.empty? && llpe_period == period)  ) &&
        ( (llpe_amount.to_s == '0.00') || ((llpe_amount.to_s == amount.to_s) && (llpe_debit_credit_code == debit_credit_code)) )
        return true
    else
      return false
    end
  end


  def get_benefits_clearing_account
    clearing_accounts =  get_parameter_values('KFS-LD', 'BENEFIT_CLEARING_ACCOUNT_NUMBER', 'SalaryExpenseTransfer')
    return clearing_accounts[0]
  end


  # The caller should provide a local copy of the accounting lines as this method will add the additional attributes
  # required for LLPE validation to each accounting line hash after they are looked up and/or calculated.
  # @return [Hash][Array][Hash] Accounting lines with related benefits attributes added to each line's hash
  # @param st_accounting_lines Accounting lines from the salary expense transfer page.
  # @param type The symbol representing the type of the accounting line
  def determine_additional_llpe_attributes(st_accounting_lines, type)

    st_accounting_lines[type].each do |line|
      # Account Lookup as webservice call to get labor benefit rate category code on the account
      account_info = get_kuali_business_object('KFS-COA','Account',"closed=N&accountNumber=#{line[:account_number]}")

      # Labor Object Code Benefits Lookup as webservice call to get labor benefits type code
      labor_benefit_type_info = get_kuali_business_object('KFS-LD','PositionObjectBenefit',"universityFiscalYear=#{line[:payroll_end_date_fiscal_year]}&chartOfAccountsCode=#{line[:chart_code]}&financialObjectCode=#{line[:object_code]}")

      # Labor Benefits Calculation Lookup as webservice call using labor benefit rate category code and
      # labor benefits type code to get labor benefit object code, labor account code offset, and position fringe benefit percent
      labor_calc_info = get_kuali_business_object('KFS-LD','BenefitsCalculation',"universityFiscalYear=#{line[:payroll_end_date_fiscal_year]}&chartOfAccountsCode=#{line[:chart_code]}&positionBenefitTypeCode=#{labor_benefit_type_info['financialObjectBenefitsTypeCode'][0]}&laborBenefitRateCategoryCode=#{account_info['laborBenefitRateCategoryCode'][0]}")

      # Determine what the benefits amount should be based on the percentage just retrieved.
      benefit_amount = calculate_benefit_amount((line[:amount]).to_f, (labor_calc_info['positionFringeBenefitPercent'][0]).to_f)

      #Now add the benefit attributes to the accounting line
      line.merge!({
                     benefit_object:  labor_calc_info['positionFringeBenefitObjectCode'][0],
                     benefit_amount:  benefit_amount
                  })
    end #for each accounting line
    return st_accounting_lines
  end


  def create_llpe_line(account, object, period, balance_type, amount, debit_credit_code)
    data_line = {
                   account_number:     account,
                   object:             object,
                   period:             period,
                   balance_type:       balance_type,
                   amount:             amount,
                   debit_credit_code:  debit_credit_code
    }
    return data_line
  end


  # @return [Array][Hash] An array of hash values representing the labor ledger pending entries values used for comparison during validation
  # @param page The page the labor ledger pending entries results table should exist on.
  def get_llpe_results_data(page)
    #get the column identifiers once to be used multiple times
    llpe_num_rows = page.llpe_results_table.rows.length-1
    account_number_col = page.llpe_results_table.keyed_column_index(:account_number)
    object_code_col = page.llpe_results_table.keyed_column_index(:object)
    period_col = page.llpe_results_table.keyed_column_index(:period)
    balance_type_col = page.llpe_results_table.keyed_column_index(:balance_type)
    amount_col = page.llpe_results_table.keyed_column_index(:amount)
    dc_col = page.llpe_results_table.keyed_column_index(:debit_credit_code)

    llpe_results_data = Array.new
    page.llpe_results_table.rest.each do |llperow|
      data_line = Hash.new
      data_line = create_llpe_line(llperow[account_number_col].text.strip,
                                   llperow[object_code_col].text.strip,
                                   llperow[period_col].text.strip,
                                   llperow[balance_type_col].text.strip,
                                   (llperow[amount_col].text.strip).gsub(/,/, ''),   #remove any commas that may be present i.e. 1,234.56
                                   llperow[dc_col].text.strip)
      llpe_results_data.push(data_line)
    end
    return llpe_results_data
  end


  # @return [Array][Hash] An array of hash values representing expected labor ledger pending entries values based on the
  #                       accounting line labor and benefits attributes used for comparison during validation
  # @param st_accounting_lines Accounting line data with associated benefits attributes included in each line hash
  def generate_expected_llpe_data(st_accounting_lines)

    expected_llpe_data = Array.new

    #create labor and benefit llpe lines for all From accounts
    st_accounting_lines[:source].each do |line|
      # create three source labor rows for each source accounting line
      data_line = create_llpe_line(line[:account_number], line[:object_code], @period_unassigned, @actuals_balance_type, line[:amount], @credit_code)
      expected_llpe_data.push(data_line)
      data_line = create_llpe_line(line[:account_number], line[:object_code], @period_unassigned, @labor_balance_type, line[:amount], @debit_code)
      expected_llpe_data.push(data_line)
      data_line = create_llpe_line(line[:account_number], line[:object_code], line[:payroll_end_date_fiscal_period_code], @labor_balance_type, line[:amount], @credit_code)
      expected_llpe_data.push(data_line)

      # create three source benefits rows when benefits amount is not zero
      if line[:benefit_amount] != 0
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], @period_unassigned, @actuals_balance_type, line[:benefit_amount], @credit_code)
        expected_llpe_data.push(data_line)
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], @period_unassigned, @labor_balance_type, line[:benefit_amount], @debit_code)
        expected_llpe_data.push(data_line)
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], line[:payroll_end_date_fiscal_period_code], @labor_balance_type, line[:benefit_amount], @credit_code)
        expected_llpe_data.push(data_line)
      end
    end #source accounting line

    #create labor and benefit llpe lines for all To accounts
    st_accounting_lines[:target].each do |line|
      # create three target labor rows
      data_line = create_llpe_line(line[:account_number], line[:object_code], @period_unassigned, @actuals_balance_type, line[:amount], @debit_code)
      expected_llpe_data.push(data_line)
      data_line = create_llpe_line(line[:account_number], line[:object_code], @period_unassigned, @labor_balance_type, line[:amount], @credit_code)
      expected_llpe_data.push(data_line)
      data_line = create_llpe_line(line[:account_number], line[:object_code], line[:payroll_end_date_fiscal_period_code], @labor_balance_type, line[:amount], @debit_code)
      expected_llpe_data.push(data_line)

      # create three target benefits rows when benefits amount is not zero
      if line[:benefit_amount] != 0
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], @period_unassigned, @actuals_balance_type, line[:benefit_amount], @debit_code)
        expected_llpe_data.push(data_line)
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], @period_unassigned, @labor_balance_type, line[:benefit_amount], @credit_code)
        expected_llpe_data.push(data_line)
        data_line = create_llpe_line(line[:account_number], line[:benefit_object], line[:payroll_end_date_fiscal_period_code], @labor_balance_type, line[:benefit_amount], @debit_code)
        expected_llpe_data.push(data_line)
      end
    end #source accounting line

    #create clearing account llpe lines only if the benefit rates are different
    need_clearing_account_entries = false
    st_accounting_lines[:source].each do |from_line|
      st_accounting_lines[:target].each do |to_line|
        if from_line[:benefit_amount] != to_line[:benefit_amount]
          #found differing benefit amounts
          need_clearing_account_entries = true
          break
        end
      end
      if need_clearing_account_entries
        # no need to continue to look, get out of outer loop
        break
      end
    end

    if need_clearing_account_entries
      #Obtain the clearing account
      clearing_account = get_benefits_clearing_account

      # clearing account lines that only differ by amount need to be consolidated,  creating new array for the clearing
      # entries so there are fewer to search through for this consolidation after all have been created
      # after all clearing account entries
      clearing_entries = Array.new
      create_clearing_account_benefit_entries(clearing_account, clearing_entries, st_accounting_lines, :source, @debit_code)
      create_clearing_account_benefit_entries(clearing_account, clearing_entries, st_accounting_lines, :target, @credit_code)

      #now add the clearing account entries to the expected_llpe_data
      clearing_entries.each do |entry|
        expected_llpe_data.push(entry)
      end
    end #need_clearing_account_entries

    return expected_llpe_data
  end


  def create_clearing_account_benefit_entries(clearing_account, clearing_entries, st_accounting_lines, type, debit_credit_code)
    st_accounting_lines[type].each do |line|
      unless clearing_entries.empty?
        same_benefits_object_found = false
        same_object_index = -1
        clearing_entries.each_with_index do |clearing_line, index|
          if line[:benefit_object] == clearing_line[:benefit_object]
            same_benefits_object_found = true
            same_object_index = index
            break
          end
        end
        if same_benefits_object_found
          # add the amount to the existing clearing account entry amount
          entry = Hash.new
          entry = clearing_entries[same_object_index]
          new_amount = {amount: (entry[:amount] + line[:amount])}
          entry.merge!(new_amount)
        else #same benefits object code not found, create new clearing account entry
          data_line = create_llpe_line(clearing_account, line[:benefit_object], @period_unassigned, @actuals_balance_type, line[:benefit_amount], debit_credit_code)
          clearing_entries.push(data_line)
        end

      else #unless -- first element being put in clearing_entries
        data_line = create_llpe_line(clearing_account, line[:benefit_object], @period_unassigned, @actuals_balance_type, line[:benefit_amount], debit_credit_code)
        clearing_entries.push(data_line)
      end
    end
    return clearing_entries
  end

end
