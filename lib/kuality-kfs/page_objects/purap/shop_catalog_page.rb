class ShopCatalogPage < KFSBasePage

  def self.eshop_frame(b)
    b.iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').iframe(id: 'iframeportlet')
  end

#REQUISITION DETAIL
  action(:go_button) { |b| eshop_frame(b).button(value: 'Go' ).click } #there is space after search
  element(:key_words) { |b| eshop_frame(b).text_field(id: 'Keywords', title: 'Search terms') }
  element(:search_results) { |b| eshop_frame(b).table(class: 'SearchResults') }
  action(:order_doc) { |b| eshop_frame(b).link(id: 'PHX_NAV_OrdersAndDocuments_Invoker' ).click } #there is space after search
  action(:po_doc_search) { |b| eshop_frame(b).link(id: 'PHX_NAV_DocumentSearchSearch' ).click } #there is space after search
  element(:po_id) { |b| eshop_frame(b).textarea(id: 'purchaseOrder_AdvancedSearch_PO_Document_Number-InputText') }
  element(:go_buttons) { |b| eshop_frame(b).buttons(value: 'Go' )} #there is space after search
  action(:po_doc_row) { |match, b| b.search_results.row(text: /#{match}/m) }
  action(:return_po_value) { |match, p| p.po_doc_row(match).link(text: match).click }
  element(:doc_summary) { |b| eshop_frame(b).tds(class: 'DocSummaryBox') }
  action(:doc_po_link) { |b| eshop_frame(b).a(text: 'Purchase Order').click }
  action(:attachments_link) { |b| eshop_frame(b).a(text: 'Attachments').click }
end