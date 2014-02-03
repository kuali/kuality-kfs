class BudgetAdjustmentObject < KFSDataObject

  attr_accessor  :fdd_year, :from_chart_code, :from_account_number,
                 :from_object_code, :from_current_amount, :from_base_amount, :from_line_description,

                 :to_chart_code, :to_account_number, :to_object_code, :to_current_amount, :to_base_amount, :to_line_description,
                 :converted_month_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),
        from_chart_code: 'IT',
        from_account_number: '1258322',
        from_object_code: '4480',
        from_current_amount: '10000',
        converted_month_number: get_month_conversion
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).budget_adjustment

    on BudgetAdjustmentPage do |page|
      @document_id = page.document_id
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :fdd_year,
               :from_chart_code, :from_account_number, :from_object_code, :from_current_amount, :from_base_amount, :from_line_description
      page.add_from_accounting_line unless @from_account_number.nil?

      fill_out page, :to_chart_code, :to_account_number, :to_object_code, :to_current_amount, :to_base_amount, :to_line_description
      page.add_to_accounting_line unless @to_account_number.nil?

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

  def viewAsUser(username)
    @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{username}"
  end

  #def view
  #  #TODO:: not sure if this global variable works
  #  @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{$users.current_user}"
  #end

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

  #private
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
