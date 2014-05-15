class BenefitExpenseTransferObject < KFSDataObject


  DOC_INFO = { label: 'Benefit Expense Transfer Document', type_code: 'BT' }

  attr_accessor :import_chart_code, :import_account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(20, 'AFT'),
        import_chart_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        import_account_number: 'G398338'
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).benefit_expense_transfer
    on BenefitExpenseTransferPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :import_chart_code, :import_account_number
    end
  end

end