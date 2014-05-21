class ServiceBillingObject < KFSDataObject

  include AccountingLinesMixin

  # These aliases are for convenience
  alias :add_expense_line :add_target_line
  alias :add_income_line :add_source_line
  alias :import_expense_lines :import_target_lines
  alias :import_income_line :import_source_lines

  DOC_INFO = { label: 'Service Billing Document', type_code: 'SB' }

  attr_accessor   :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description: random_alphanums(40, 'AFT')
    }.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_SERVICE_BILLING)).merge(opts))
  end

  def build
    visit(MainPage).service_billing
    on ServiceBillingPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

end
