class CreditCardReceiptPage < FinancialProcessingPage

    financial_document_detail
    accounting_lines

    ad_hoc_recipients

    #accounting_lines_for_capitalization

    #create_capital_assets

    #modify_capital_assests


    #Credit Card Receipts
    element(:receipt_type) { |b| b.frm.text_field(name: 'newCreditCardReceipt.financialDocumentCreditCardTypeCode') }
    element(:receipt_vendor_number) { |b| b.frm.text_field(name: 'newCreditCardReceipt.financialDocumentCreditCardVendorNumber') }
    element(:receipt_date) { |b| b.frm.text_field(name: 'newCreditCardReceipt.creditCardDepositDate') }
    element(:receipt_reference_number) { |b| b.frm.text_field(name: 'newCreditCardReceipt.creditCardDepositReferenceNumber') }
    element(:receipt_amount) { |b| b.frm.text_field(name: 'newCreditCardReceipt.creditCardAdvanceDepositAmount') }
    action(:add_a_credit_card_receipt) { |b| b.frm.button(title: 'Add a Credit Card Receipt').click }

  end