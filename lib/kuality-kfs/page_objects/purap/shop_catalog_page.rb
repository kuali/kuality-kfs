class ShopCatalogPage < EShopPage

#REQUISITION DETAIL
  element(:key_words) { |b| b.frm.text_field(id: 'Keywords', title: 'Search terms') }
  element(:search_results) { |b| b.frm.table(class: 'SearchResults') }
  action(:order_doc) { |b| b.frm.link(id: 'PHX_NAV_OrdersAndDocuments_Invoker' ).click } #there is space after search
  action(:po_doc_search) { |b| b.frm.link(id: 'PHX_NAV_DocumentSearchSearch' ).click } #there is space after search
  element(:po_id) { |b| b.frm.textarea(id: 'purchaseOrder_AdvancedSearch_PO_Document_Number-InputText') }

  # == These are actually on the document search page ==
  element(:date_range) { |b| b.frm.select(id: 'poAdvInput', name: 'DateRangeSelector') }
  element(:go_button) { |b|
    b.frm.form(name: 'AdvancedSearchPurchaseOrdersInputForm')
         .table
         .tr(id: 'AdvancedSearchButton')
         .buttons(value: 'Go')
         .to_a
         .keep_if{ |btn| btn.visible? }
         .first # This should give you only the one true button. There are some hidden ones.
  }

  action(:po_doc_row) { |match, b| b.search_results.row(text: /#{match}/m) }
  action(:return_po_value) { |match, p| p.po_doc_row(match).link(text: match).click }
  element(:search_doc_type) { |b| b.frm.select(id: 'AdvancedSearchDocumentTypeSelector') }
  
  # == ==

  # == This section is really a PO Summary page
  element(:doc_summary) { |b| b.frm.tds(class: 'DocSummaryBox') }
  action(:doc_po_link) { |b| b.frm.a(text: 'Purchase Order').click }
  action(:attachments_link) { |b| b.frm.a(text: 'Attachments').click }

  # == ==

  element(:panel_right) { |b| b.frm.divs(class: 'HomeShopPanelRight') }
  element(:showcased_services_section) { |b| b.panel_right.td(text: 'Showcased Services').parent.parent } # Should be the selector div
  action(:showcased_services) { |i=0, b| b.showcased_services_section.buttons[i] }
  element(:hosted_suppliers_section) { |b| b.panel_right[b.panel_right.to_a.index { |d| d.text.match(/Hosted Suppliers/m) }] } # Should be the selector div
  value(:hosted_supplier_id) { |s, b| b.hosted_supplier(s).parent.id.gsub(/^.*_so/, '') }
  element(:hosted_suppliers_buttons) { |b| b.hosted_suppliers_section.div(id: "container-#{b.hosted_suppliers_section.id}").table.tds(class: 'sticker') }
  element(:hosted_supplier) { |s, b| b.hosted_suppliers_section.img(title: s) }
  action(:choose_hosted_supplier) { |s, b| b.hosted_supplier(s).click }
  action(:hosted_suppliers) { |i=0, b| b.hosted_suppliers_buttons[i].images.first }
  element(:punch_out_section) { |b| b.panel_right.td(text: 'Punch-out').parent.parent } # Should be the selector div
  action(:punch_out) { |i=0, b| b.punch_out_section.buttons[i] }

  element(:hosted_supplier_item_search_popup) { |s, b| b.hosted_supplier(s).parent.text_field(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so").parent }
  element(:hosted_supplier_item_search_box) { |s, b| b.hosted_supplier_item_search_popup(s).text_field(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so") }
  element(:hosted_supplier_item_search) { |s, b| b.hosted_supplier_item_search_popup(s).input(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so_button").click }


  
end