class CabPurapLookupPage < Lookups
  element(:po_number) { |b| b.frm.text_field(id: 'referenceFinancialDocumentNumber') }
  element(:preq_number) { |b| b.frm.text_field(id: 'purapDocumentIdentifier') }


end
