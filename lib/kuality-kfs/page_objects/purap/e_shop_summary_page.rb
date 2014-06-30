class EShopSummaryPage < EShopPage

  element(:search_results) { |b| b.frm.table(class: 'SearchResults') }
  element(:doc_summary) { |b| b.frm.tds(class: 'DocSummaryBox') }
  action(:doc_po_link) { |b| b.frm.a(text: 'Purchase Order').click }
  action(:attachments_link) { |b| b.frm.a(text: 'Attachments').click }

end