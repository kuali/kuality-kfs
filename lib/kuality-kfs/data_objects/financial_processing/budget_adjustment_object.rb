class BudgetAdjustmentObject < KFSDataObject

  attr_accessor  :fdd_year, :from_chart_code, :from_account_number, :from_object_code, :from_current_amount,
                 :to_chart_code, :to_object_code, :to_current_amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),
        from_chart_code: 'IT',
        from_account_number: ['1258322'],
        from_object_code: '4480',
        from_current_amount: '10000'
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
               :from_chart_code, :from_account_number, :from_object_code, :from_current_amount
      page.add_from_accounting_line unless @from_account_number.nil?

      fill_out page, :to_chart_code, :to_account_number, :to_object_code, :to_current_amount
      page.add_to_accounting_line unless @to_account_number.nil?

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

  def viewAsUser(username)
    @browser.goto "#{base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{username}"
  end

  def view
    #TODO:: Fix this view url for Budget Adjustment
    @browser.goto "#{base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{$users.current_user}"
  end


end #class
