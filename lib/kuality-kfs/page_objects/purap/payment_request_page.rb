class PaymentRequestPage < KFSBasePage

  element(:vendor_address_1) { |b| b.frm.text_field(name: 'document.vendorLine1Address') }
  element(:pay_date) { |b| b.frm.text_field(name: 'document.paymentRequestPayDate') }

  action(:item_qty_invoiced) { | i=0, b| b.frm.text_field(name: "document.item[#{i}].itemQuantity") }
  action(:item_calculate) { | i=0, b| b.frm.button(name: /methodToCall.recalculateItemAccountsAmounts.line#{i}./).click }

  # TODO : there should have a purap page for shared purap page element.
  action(:calculate) { |b| b.frm.button(name: 'methodToCall.calculate').click }

end