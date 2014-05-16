class CABPurchasingAccountsPayableReportLookupPage < Lookups


  document_facets
  account_facets
  fiscal_year_facets
  submit_to_cams_radios
  financial_object_facets

  element(:purchase_order) { |b| b.frm.text_field(name: 'referenceFinancialDocumentNumber') }
  element(:document_type_select) { |b| b.frm.select(name: 'financialDocumentTypeCode') }
  element(:preq_cm_id) { |b| b.frm.text_field(name: 'purapDocumentIdentifier') }

  element(:transaction_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_transactionDate') }
  element(:transaction_date_to) { |b| b.frm.text_field(name: 'transactionDate') }

end