class DistributionOfIncomeAndExpenseObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Distribution Of Income And Expense Document', type_code: 'DI' }

  attr_accessor :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_DISTRIBUTION_OF_INCOME_AND_EXPENSE)).merge(opts))
  end

  def build
    visit(MainPage).distribution_of_income_and_expense
    on DistributionOfIncomeAndExpensePage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

end