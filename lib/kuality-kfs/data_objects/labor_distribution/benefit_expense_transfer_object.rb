class BenefitExpenseTransferObject < KFSDataObject


  DOC_INFO = { label: 'Benefit Expense Transfer Document', type_code: 'BT' }

  attr_accessor :chart_code, :account_number, :sub_account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(20, 'AFT'),
        chart_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        account_number: get_aft_parameter_value(ParameterConstants::DEFAULT_BT_ACCOUNT_NUMBER)
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).benefit_expense_transfer
    on BenefitExpenseTransferPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :account_number
    end
  end

end