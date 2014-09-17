class InternalBillingObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Internal Billing Document', type_code: 'IB', transactional?: true }

  attr_accessor :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_INTERNAL_BILLING)).merge(opts))
  end

  def build
    visit(MainPage).internal_billing
    on InternalBillingPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

end