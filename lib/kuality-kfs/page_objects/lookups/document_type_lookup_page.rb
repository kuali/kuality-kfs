class DocumentTypeLookupPage < Lookups

  element(:name) { |b| b.frm.text_field(name: 'name') }
  element(:gdocument_type_id) { |b| b.frm.text_field(name: 'documentTypeId') }

end