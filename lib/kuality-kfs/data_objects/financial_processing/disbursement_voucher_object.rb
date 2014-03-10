class DisbursementVoucherObject < KFSDataObject

  DOC_INFO = { label: 'Disbursement Voucher Document', type_code: 'DV' }

  include PaymentInformationMixin
  include AccountingLinesMixin
  alias :add_target_line :add_source_line

  attr_accessor :organization_document_number, :explanation,
                :contact_name, :phone_number, :email_address,
                :foreign_draft_in_usd, :foreign_draft_in_foreign_currency, :currency_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                       random_alphanums(40, 'AFT'),
        #foreign_draft_in_foreign_currency: :set,
        #currency_type:                     'Canadian $'
    }.merge!(default_accounting_lines(opts[:account_default].nil? ? {} : opts[:account_default]))
     .merge!(default_payment_information_lines(opts[:payment_default].nil? ? {} : opts[:payment_default]))

    set_options(defaults.merge(opts[:dv_default].nil? ? {} : opts[:dv_default]))
  end

  def build
    visit(MainPage).disbursement_voucher
    on DisbursementVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation,
               :contact_name, :phone_number, :email_address,
               :foreign_draft_in_usd, :foreign_draft_in_foreign_currency, :currency_type
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