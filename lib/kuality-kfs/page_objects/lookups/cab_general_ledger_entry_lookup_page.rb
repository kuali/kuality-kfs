class CABGeneralLedgerEntryLookupPage < Lookups

  fiscal_year_facets
  account_facets
  subaccount_facets
  financial_object_facets
  document_facets
  reference_document_facets
  submit_to_cams_radios

  element(:document_type) { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }

  element(:organization_document_number) { |b| b.frm.text_field(name: 'organizationDocumentNumber') }
  element(:organization_reference_id) { |b| b.frm.text_field(name: 'organizationReferenceId') }

  element(:transaction_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_transactionDate') }
  element(:transaction_date_to) { |b| b.frm.text_field(name: 'transactionDate') }

end