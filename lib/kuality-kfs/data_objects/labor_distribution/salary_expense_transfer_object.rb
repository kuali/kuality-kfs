class SalaryExpenseTransferObject < KFSDataObject


  DOC_INFO = { label: 'Salary Expense Transfer Document', type_code: 'ST' }

  attr_accessor :empl_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(20, 'AFT'),
        empl_id: get_aft_parameter_value(ParameterConstants::DEFAULT_ST_EMPL_ID)
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).salary_expense_transfer
    on SalaryExpenseTransferPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :empl_id
    end
  end

end