class CABGeneralLedgerEntryLookupPage < Lookups


  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'financialObjectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'financialSubObjectCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'financialObjectTypeCode') }
  element(:fiscal_period) { |b| b.frm.text_field(name: 'universityFiscalPeriodCode') }
  element(:document_type) { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }
  element(:orgin_code) { |b| b.frm.text_field(name: 'financialSystemOriginationCode') }
  element(:document_number) { |b| b.frm.text_field(name: 'documentNumber') }
  element(:organization_document_number) { |b| b.frm.text_field(name: 'organizationDocumentNumber') }
  element(:organization_reference_id) { |b| b.frm.text_field(name: 'organizationReferenceId') }
  element(:reference_origin_code) { |b| b.frm.text_field(name: 'referenceFinancialSystemOriginationCode') }
  element(:reference_document_number) { |b| b.frm.text_field(name: 'referenceFinancialDocumentNumber') }
  element(:transaction_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_transactionDate') }
  element(:transaction_date_to) { |b| b.frm.text_field(name: 'transactionDate') }

  element(:submit_to_cams_yes) { |b| b.frm.radio(id: 'activityStatusCodeYes') }
  element(:submit_to_cams_no) { |b| b.frm.radio(id: 'activityStatusCodeNo') }
  element(:submit_to_cams_both) { |b| b.frm.radio(id: 'activityStatusCodeBoth') }


end