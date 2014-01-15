class DocumentSearchPage < BasePage

  tiny_buttons
  search_results_table

  element(:document_type) { |b| b.frm.text_field(name: documentTypeName) }
  element(:initiator) { |b| b.frm.text_field(name: initiatorPrincipalName) }
  element(:document_id) { |b| b.frm.text_field(name: documentId) }
  element(:date_created_from) { |b| b.frm.text_field(name: rangeLowerBoundKeyPrefix_dateCreated) }
  element(:date_created_to) { |b| b.frm.text_field(name: dateCreated) }
  element(:name_this_search_optional) { |b| b.frm.text_field(name: saveName) }

end
