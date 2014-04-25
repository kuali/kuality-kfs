class PaymentRequestInitiationPage < KFSBasePage

  element(:purchase_order) { |b| b.frm.text_field(name: 'document.purchaseOrderIdentifier') }
  element(:invoice_number) { |b| b.frm.text_field(name: 'document.invoiceNumber') }
  element(:invoice_date) { |b| b.frm.text_field(name: 'document.invoiceDate') }
  element(:vendor_invoice_amount) { |b| b.frm.text_field(name: 'document.vendorInvoiceAmount') }

  action(:special_handling_instructions) { |line_1_2_3=1, b| b.frm.text_field(name: "document.specialHandlingInstructionLine#{line_1_2_3}Text") }
#Or if you prefer to not pass in a value
  element(:special_handling_instructions_1) { |b| b.frm.text_field(name: 'document.specialHandlingInstructionLine1Text') }
  element(:special_handling_instructions_2) { |b| b.frm.text_field(name: 'document.specialHandlingInstructionLine2Text') }
  element(:special_handling_instructions_3) { |b| b.frm.text_field(name: 'document.specialHandlingInstructionLine3Text') }
  action(:continue) { |b| b.frm.button(name: 'methodToCall.continuePREQ').click }

end