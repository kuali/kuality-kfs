class DisbursementVoucherObject < KFSDataObject

  DOC_INFO = { label: 'Disbursement Voucher Document', type_code: 'DV' }

  include PaymentInformationMixin
  include AccountingLinesMixin
  alias :add_target_line :add_source_line

  attr_accessor :organization_document_number, :explanation,
                :contact_name, :phone_number, :email_address
                # TODO: Create a "line object" for Payment Information and add that to DV.

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).disbursement_voucher
    on DisbursementVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation,
                     :contact_name, :phone_number, :email_address
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