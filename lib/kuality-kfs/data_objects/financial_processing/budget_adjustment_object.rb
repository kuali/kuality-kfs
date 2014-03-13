class BudgetAdjustmentObject < KFSDataObject

  include BudgetAdjustmentLinesMixin

  attr_accessor  :fdd_year

  DOC_INFO = { label: 'Budget Adjustment', type_code: 'BA' }

  def default_accounting_lines(opts={})
    super(opts).merge(
        initial_lines: [{
                            type:           :source,
                            chart_code:     'IT',
                            account_number: '1258322',
                            object:         '4480',
                            current_amount: '10000'
                        }])
  end

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(20, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).budget_adjustment
    on BudgetAdjustmentPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :fdd_year
    end
  end

  def view_as(username)
    @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{username}"
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |page|
      page.document_id_field.when_present.fit @document_id
      page.search
      page.open_item(@document_id)
    end
    on(BudgetAdjustmentPage)
  end

  def adding_a_from_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    add_source_line({
                    account_number:   acct_num,
                    object:           obj_code,
                    current_amount:   current_amt,
                    base_amount:      base_amt,
                    line_description: line_desc,
                  })
  end

  def adding_a_to_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    add_target_line({
                      account_number:   acct_num,
                      object:           obj_code,
                      current_amount:   current_amt,
                      base_amount:      base_amt,
                      line_description: line_desc,
                    })
  end

end #class
