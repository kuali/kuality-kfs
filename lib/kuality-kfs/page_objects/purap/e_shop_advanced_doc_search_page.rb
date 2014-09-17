class EShopAdvancedDocSearchPage < EShopPage

  element(:date_range) { |b| b.frm.select(id: 'topInput', name: 'DateRangeSelector') }

  element(:go_button) { |b| b.frm.span(id: 'Button_Document_Search_Button').button(value: 'Go') }

  #this was not working so I corrected above, left code just in case it was needed for other tests.
  # element(:go_button) { |b|
  #   b.frm.form(name: 'AdvancedSearchPurchaseOrdersInputForm')
  #        .table
  #        .tr(id: 'AdvancedSearchButton')
  #        .buttons(value: 'Go')
  #        .to_a
  #        .keep_if{ |btn| btn.visible? }
  #        .first # This should give you only the one true button. There are some hidden ones.
  # }

  element(:po_doc_row) { |match, b| b.search_results.row(text: /#{match}/m) }
  action(:return_po_value) { |match, p| p.po_doc_row(match).link(text: match).click }
  element(:search_doc_type) { |b| b.frm.select(name: 'Document_Type_Selector') }
  element(:po_id) { |b|  b.frm.text_field(name: 'SimpleSearch_Keyword') }

end