class ServiceBillingObject < KFSDataObject

  DOC_INFO = { label: 'Service Billing Document', type_code: 'SB' }

  include AccountingLinesMixin

  # These aliases are for convenience
  alias add_expense_line add_target_line
  alias add_income_line add_source_line

  attr_accessor   :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description: random_alphanums(40, 'AFT')
    }.merge!(default_accounting_lines)

    set_options(defaults.merge(opts))
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

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      search.open_doc @document_id
    end
  end

end
