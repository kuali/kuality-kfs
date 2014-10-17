class IndirectCostRecoveryRateObject < KFSDataObject

attr_accessor :fiscal_year, :rate_id, :active_indicator, :indirect_cost_recovery_rate_details


  DOC_INFO = { label: 'Indirect Cost Recovery Rate', type_code: 'ICRE' }

  def defaults
    super.merge({
                    fiscal_year:                            get_aft_parameter_value('CURRENT_FISCAL_YEAR'),
                    rate_id:                                random_alphanums(3),
                    active_indicator:                       :set,
                    indirect_cost_recovery_rate_details:    collection('IndirectCostRecoveryRateDetailLineObject')
               })
  end


  def build
    visit(MaintenancePage).indirect_cost_recovery_rate
    on(IndirectCostRecoveryRateLookupPage).create_new
    on IndirectCostRecoveryRatePage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :rate_id, :active_indicator
    end
  end


  def absorb!(target=:new)
    super
    update_options(pull_indirect_cost_recovery_rate_data(target))
    update_line_objects_from_page!(target)
  end


  # @return [Hash] The return values of attributes for the new Indirect Cost Recovery Rate
  def pull_indirect_cost_recovery_rate_data(target=:new)
    pulled_indirect_cost_recovery_rate = Hash.new
    on IndirectCostRecoveryRatePage do |page|
      page.expand_all
      case target
        when :new;      pulled_indirect_cost_recovery_rate = {
                            fiscal_year:        page.fiscal_year_new,
                            rate_id:            page.rate_id_new,
                            active_indicator:   page.active_indicator_new
                        }
        #TODO implement :old when needed
      end
    end
    pulled_indirect_cost_recovery_rate.merge(pull_indirect_cost_recovery_rate_extended_data(target))
  end


  def pull_indirect_cost_recovery_rate_extended_data(target=:new)
    Hash.new
  end


  def update_line_objects_from_page!(target=:new)
    @indirect_cost_recovery_rate_details.update_from_page! target
    super
  end



  def add_wildcarded_icr_rate_for_random_institutional_object_codes(percent_to_use)
    #get random institutional allowance object code
    debit_object_code_info = get_kuali_business_object('KFS-COA','ObjectCode',"universityFiscalYear=#{get_aft_parameter_value(ParameterConstants::CURRENT_FISCAL_YEAR)}&chartOfAccountsCode=#{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}&financialObjectLevelCode=IAEX&financialObjectTypeCode=ES&active=true")
    @debit_object_code = debit_object_code_info['financialObjectCode'][0]
    credit_object_code_info = get_kuali_business_object('KFS-COA','ObjectCode',"universityFiscalYear=#{get_aft_parameter_value(ParameterConstants::CURRENT_FISCAL_YEAR)}&chartOfAccountsCode=#{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}&financialObjectLevelCode=IAIN&financialObjectTypeCode=IC&active=true")
    @credit_object_code = credit_object_code_info['financialObjectCode'][0]
    add_wildcarded_icr_rate_for_specified_institutional_object_codes percent_to_use, @debit_object_code, @credit_object_code
  end


  def add_wildcarded_icr_rate_for_specified_institutional_object_codes (percent_to_use, debit_object_code, credit_object_code)
    #need two icr rate details created, one for debit and one for credit
    debit_opts = {
        chart_code:                 IndirectCostRecoveryRateDetailLineObject::DEBIT_WILDCARD,
        account_number:             IndirectCostRecoveryRateDetailLineObject::DEBIT_WILDCARD,
        sub_account_number:         IndirectCostRecoveryRateDetailLineObject::DEBIT_WILDCARD,
        object_code:                debit_object_code,
        debit_credit_code:          'Debit',
        percent:                    percent_to_use,
        details_active_indicator:   :set
    }
    icr_rate_debit_detail = make IndirectCostRecoveryRateDetailLineObject, debit_opts
    icr_rate_debit_detail.create

    credit_opts = {
        chart_code:                 IndirectCostRecoveryRateDetailLineObject::CREDIT_WILDCARD,
        account_number:             IndirectCostRecoveryRateDetailLineObject::CREDIT_WILDCARD,
        sub_account_number:         '',
        object_code:                credit_object_code,
        debit_credit_code:          'Credit',
        percent:                    percent_to_use,
        details_active_indicator:   :set
    }
    icr_rate_credit_detail = make IndirectCostRecoveryRateDetailLineObject, credit_opts
    icr_rate_credit_detail.create

    #get data from page since "add" adjusts case and populates dependent data
    absorb!(:new)
  end

end