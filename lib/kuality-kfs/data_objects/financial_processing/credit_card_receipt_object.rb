class CreditCardReceiptObject < KFSDataObject

  DOC_INFO = { label: 'Credit Card Receipt Document', type_code: 'CCR' }

  include AccountingLinesMixin

  attr_accessor :credit_card_receipts,
                :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description: random_alphanums(40, 'AFT'),
        credit_card_receipts: [
            # Dangerously close to needing to be a Data Object proper...
            { receipt_type: 'AE',
              receipt_vendor_number: '6312760432',
              receipt_date: '01/01/2014',
              receipt_reference_number: random_alphanums(4, 'AFT-CC'),
              receipt_amount: '100' }
    ]}.merge!(default_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).credit_card_receipt
    on CreditCardReceiptPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
      credit_card_receipts.each do |ccr|
        page.receipt_type.fit ccr[:receipt_type]
        page.receipt_vendor_number.fit ccr[:receipt_vendor_number]
        page.receipt_date.fit ccr[:receipt_date]
        page.receipt_reference_number.fit ccr[:receipt_reference_number]
        page.receipt_amount.fit ccr[:receipt_amount]
        page.add_a_credit_card_receipt
      end
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