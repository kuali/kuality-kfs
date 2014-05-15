class SalaryExpenseTransferObject < KFSDataObject


  DOC_INFO = { label: 'Salary Expense Transfer Document', type_code: 'ST' }

  attr_accessor :import_empl_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(20, 'AFT'),
        import_empl_id: '1013939'
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).salary_expense_transfer
    on SalaryExpenseTransferPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :import_empl_id
    end
  end

end