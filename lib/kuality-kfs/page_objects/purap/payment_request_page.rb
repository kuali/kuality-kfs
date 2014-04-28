class PaymentRequestPage < KFSBasePage

  element(:vendor_address_1) { |b| b.frm.text_field(name: 'document.vendorLine1Address') }
  element(:pay_date) { |b| b.frm.text_field(name: 'document.paymentRequestPayDate') }

  action(:item_qty_invoiced) { | i=0, b| b.frm.text_field(name: "document.item[#{i}].itemQuantity") }
  action(:item_calculate) { | i=0, b| b.frm.button(name: /methodToCall.recalculateItemAccountsAmounts.line#{i}./).click }

  # TODO : there should have a purap page for shared purap page element.
  #action(:calculate) { |b| b.frm.button(name: 'methodToCall.calculate').click }
  #GLPE (General Ledger Pending Entries)
  #action(:show_glpe) { |b| b.frm.button(title: 'open General Ledger Pending Entries').when_present.click }

  # Tax Tab
  element(:income_class_code) { |b| b.frm.select(id: 'document.taxClassificationCode') }
  element(:federal_tax_pct) { |b| b.frm.text_field(id: 'document.taxFederalPercent') }
  element(:state_tax_pct) { |b| b.frm.text_field(id: 'document.taxStatePercent') }
  element(:postal_country_code) { |b| b.frm.select(id: 'document.taxCountryCode') }


end