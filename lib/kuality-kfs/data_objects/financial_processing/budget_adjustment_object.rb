class BudgetAdjustmentObject < KFSDataObject

  include AccountingLinesMixin

  attr_accessor  :fdd_year

  def default_lines(opts={})
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

    defaults = { description: random_alphanums(20, 'AFT') }.merge!(default_lines)

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

  def self.fiscal_period_conversion(month)
    #general ledger balance lookup to select monthly link does not use numbers that match month
    return '07' if month == 'JAN'
    return '08' if month == 'FEB'
    return '09' if month == 'MAR'
    return '10' if month == 'APR'
    return '11' if month == 'MAY'
    return '12' if month == 'JUN'
    return '01' if month == 'JUL'
    return '02' if month == 'AUG'
    return '03' if month == 'SEP'
    return '04' if month == 'OCT'
    return '05' if month == 'NOV'
    return '06' if month == 'DEC'
  end

end #class
