class PreAssetTaggingLookupPage < Lookups

  active_radios

  element(:purchase_order_number) { |b| b.frm.text_field(name: 'purchaseOrderNumber') }
  element(:item_line_number) { |b| b.frm.text_field(name: 'itemLineNumber') }
  element(:quantity_ordered) { |b| b.frm.text_field(name: 'quantityInvoiced') }
  element(:tag_number) { |b| b.frm.text_field(name: 'pretagDetails.campusTagNumber') }
  element(:serial_number) { |b| b.frm.text_field(name: 'pretagDetails.serialNumber') }
  element(:purchase_order_line_item_description) { |b| b.frm.text_field(name: 'assetTopsDescription') }

end