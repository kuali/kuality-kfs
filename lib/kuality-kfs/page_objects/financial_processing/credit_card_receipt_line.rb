class CreditCardReceiptLine < FinancialProcessingPage

  element(:type) { |b| b.frm.text_field(id: 'newCreditCardReceipt.financialDocumentCreditCardTypeCode') }
  element(:vendor_number) { |b| b.frm.text_field(id: 'newCreditCardReceipt.financialDocumentCreditCardVendorNumber') }
  element(:date) { |b| b.frm.text_field(id: 'newCreditCardReceipt.creditCardDepositDate') }
  element(:ref_nbr) { |b| b.frm.text_field(id: 'newCreditCardReceipt.creditCardDepositReferenceNumber') }
  element(:amount) { |b| b.frm.text_field(id: 'newCreditCardReceipt.creditCardAdvanceDepositAmount') }

  action(:update_type) { |i, b| b.frm.text_field(id: "document.creditCardReceipt[#{i}].financialDocumentCreditCardTypeCode") }
  action(:update_vendor_number) { |i, b| b.frm.text_field(id: "document.creditCardReceipt[#{i}].financialDocumentCreditCardVendorNumber") }
  action(:update_date) { |i, b| b.frm.text_field(id: "document.creditCardReceipt[#{i}].creditCardDepositDate") }
  action(:update_ref_nbr) { |i, b| b.frm.text_field(id: "document.creditCardReceipt[#{i}].creditCardDepositReferenceNumber") }
  action(:update_amount) { |i, b| b.frm.text_field(id: "document.creditCardReceipt[#{i}].creditCardAdvanceDepositAmount") }

  action(:add_credit_card_receipt_line) { |b| b.frm.button(name: 'methodToCall.addCreditCardReceipt').click }
  action(:delete_credit_card_receipt_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteCreditCardReceipt.line#{l}").click }

end
