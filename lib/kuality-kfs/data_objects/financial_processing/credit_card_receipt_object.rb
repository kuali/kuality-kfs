class CreditCardReceiptObject < KFSDataObject

  DOC_INFO = { label: 'Credit Card Receipt Document', type_code: 'CCR' }

  include AccountingLinesMixin

  attr_accessor :organization_document_number, :explanation,
                :credit_card_receipts

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
                 description:          random_alphanums(40, 'AFT'),
                 credit_card_receipts: collection('CreditCardReceiptLineObject')
               }.merge!(default_accounting_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).credit_card_receipt
    on CreditCardReceiptPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

  def post_create
    super
    add_credit_card_receipt_line # We need at least one CCR line
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit   @document_id
      search.search
      search.open_doc @document_id
    end
  end

  def add_credit_card_receipt_line(opts={})
    on(CreditCardReceiptPage) { @credit_card_receipts.add(opts) }
  end

  def delete_credit_card_receipt_line(line_number=0)
    on(CreditCardReceiptPage) { @credit_card_receipts.delete_at(line_number) }
  end

end