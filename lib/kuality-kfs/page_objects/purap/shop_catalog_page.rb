class ShopCatalogPage < KFSBasePage

#REQUISITION DETAIL
  action(:go_button) { |b| b.frm.button(value: 'Go' ).click } #there is space after search
  element(:key_words) { |b| b.frm.text_field(id: 'Keywords', title: 'Search terms') }
  element(:search_results) { |b| b.frm.table(class: 'SearchResults') }
  action(:order_doc) { |b| b.frm.link(id: 'PHX_NAV_OrdersAndDocuments_Invoker' ).click } #there is space after search
  action(:po_doc_search) { |b| b.frm.link(id: 'PHX_NAV_DocumentSearchSearch' ).click } #there is space after search
  element(:po_id) { |b| b.frm.textarea(id: 'purchaseOrder_AdvancedSearch_PO_Document_Number-InputText') }
  element(:date_range) { |b| b.frm.selects(name: 'DateRangeSelector') } # multiple of them
  element(:go_buttons) { |b| b.frm.buttons(value: 'Go' )} #there is space after search
  action(:po_doc_row) { |match, b| b.search_results.row(text: /#{match}/m) }
  action(:return_po_value) { |match, p| p.po_doc_row(match).link(text: match).click }
  element(:doc_summary) { |b| b.frm.tds(class: 'DocSummaryBox') }
  action(:doc_po_link) { |b| b.frm.a(text: 'Purchase Order').click }
  action(:attachments_link) { |b| b.frm.a(text: 'Attachments').click }
end