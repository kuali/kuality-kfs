class BudgetAdjustmentObject < FinancialProcessingObject

  DOC_INFO = { label: 'Budget Adjustment', type_code: 'BA' }

  attr_accessor  :fdd_year

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),
         accounting_lines: [
        # Dangerously close to needing to be a Data Object proper...
        { from_chart_code: 'IT', from_account_number: '1258322', #TODO get from config
          from_object_code: '4480', #TODO get from config
          from_current_amount: '100', add_accounting_line: true
        } ]
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

      accounting_lines.each do |dep|
        page.from_chart_code.fit dep[:from_chart_code]
        page.from_account_number.fit dep[:from_account_number]
        page.from_object_code.fit dep[:from_object_code]
        page.from_current_amount.fit dep[:from_current_amount]
        page.add_from_accounting_line unless @add_accounting_line == false
      end

      accounting_lines.each do |dep|
        page.to_chart_code.fit dep[:to_chart_code]
        page.to_account_number.fit dep[:to_account_number]
        page.to_object_code.fit dep[:to_object_code]
        page.to_current_amount.fit dep[:to_current_amount]
        page.add_to_accounting_line unless @add_accounting_line == false
      end

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

  #def viewAsUse
  #  @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{$users.current_user}"
  #end

  def view
    "#{$base_url}financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #"#{$base_url}financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #"https://kfs-ci.kuali.cornell.edu/kfs/financialBudgetAdjustment.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView&backdoorId=lrz8#topOfForm"
  end

end #class
