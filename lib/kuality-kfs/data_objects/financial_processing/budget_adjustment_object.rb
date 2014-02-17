class BudgetAdjustmentObject < FinancialProcessingObject

  DOC_INFO = { label: 'Budget Adjustment', type_code: 'BA' }
  
  attr_accessor  :fdd_year, :from_chart_code, :from_account_number,
                 :from_object_code, :from_current_amount, :from_base_amount, :from_line_description,

                 :to_chart_code, :to_account_number, :to_object_code, :to_current_amount, :to_base_amount, :to_line_description,
                 :converted_month_number,
                 :from_file_name, :to_file_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),

        converted_month_number: get_month_conversion,
         accounting_lines: [
        # Dangerously close to needing to be a Data Object proper...
        { from_chart_code: 'IT', from_account_number: '1258322', #TODO get from config
          from_object_code: '4480', #TODO get from config
          from_current_amount: '100',
        } ], add_accounting_line: true,
         from_lines:                      collection('AccountingLineObject'),
         to_lines:                        collection('AccountingLineObject')
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).budget_adjustment

    on BudgetAdjustmentPage do |page|
      @document_id = page.document_id
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :fdd_year

      if @add_accounting_line == true
        accounting_lines.each do |dep|
          page.from_chart_code.fit dep[:from_chart_code]
          page.from_account_number.fit dep[:from_account_number]
          page.from_object_code.fit dep[:from_object_code]
          page.from_current_amount.fit dep[:from_current_amount]
          page.from_base_amount.fit dep[:from_base_amount]
          page.from_line_description.fit dep[:from_line_description]
          page.add_from_accounting_line unless @from_account_number.nil?
        end

        accounting_lines.each do |dep|
          page.to_chart_code.fit dep[:to_chart_code]
          page.to_account_number.fit dep[:to_account_number]
          page.to_object_code.fit dep[:to_object_code]
          page.to_current_amount.fit dep[:to_current_amount]
          page.to_base_amount.fit dep[:to_base_amount]
          page.to_line_description.fit dep[:to_line_description]
          page.add_to_accounting_line unless @to_account_number.nil?
        end
      end

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

  def view
    @browser.goto "#{$base_url}financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #"https://kfs-ci.kuali.cornell.edu/kfs/financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView&backdoorId=lrz8#topOfForm"
    #@browser.goto "{$base_url}financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def view_as(username)
    @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{username}"
  end


  def view_document
    visit(MainPage).doc_search
    on DocumentSearch do |page|
      page.document_id_field.when_present.fit @document_id
      page.search
      page.open_item(@document_id)
    end
    #on(BudgetAdjustmentPage)
  end

  def adding_a_from_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    page.from_account_number.fit acct_num
    page.from_object_code.fit obj_code
    page.from_current_amount.fit current_amt
    page.from_line_description.fit line_desc
    page.from_base_amount.fit base_amt

    page.add_from_accounting_line
  end

  def adding_a_to_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    page.to_account_number.fit acct_num
    page.to_object_code.fit obj_code
    page.to_current_amount.fit current_amt
    page.to_line_description.fit line_desc
    page.to_base_amount.fit base_amt

    page.add_to_accounting_line
  end

  def get_month_conversion
    #general ledger balance lookup to select monthly link does not use numbers that match month
    return '07' if current_month == 'JAN'
    return '08' if current_month == 'FEB'
    return '09' if current_month == 'MAR'
    return '10' if current_month == 'APR'
    return '11' if current_month == 'MAY'
    return '12' if current_month == 'JUN'
    return '01' if current_month == 'JUL'
    return '02' if current_month == 'AUG'
    return '03' if current_month == 'SEP'
    return '04' if current_month == 'OCT'
    return '05' if current_month == 'NOV'
    return '06' if current_month == 'DEC'
  end

end #class
