class DocumentSearch < Lookups

  page_url "#{$base_url}portal.do?channelTitle=Document%20Search&channelUrl=#{$base_rice_url}kew/DocumentSearch.do"

  element(:document_type) { |b| b.frm.text_field(name: 'documentTypeName') }
  element(:initiator) { |b| b.frm.text_field(name: 'initiatorPrincipalName') }
  element(:document_id_field) { |b| b.frm.text_field(name: 'documentId') }
  element(:date_created_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_dateCreated') }
  element(:date_created_to) { |b| b.frm.text_field(name: 'dateCreated') }
  element(:name_this_search_optional) { |b| b.frm.text_field(name: 'saveName') }

  element(:document_id) { |b| b.frm.text_field(id: 'documentId') }

  action(:open_doc) { |document_id, b| b.frm.link(text: document_id).click; b.use_new_tab; b.close_parents }
  action(:doc_status) { |document_id, b| b.results_table.row(text: /#{document_id}/)[3].text }

end