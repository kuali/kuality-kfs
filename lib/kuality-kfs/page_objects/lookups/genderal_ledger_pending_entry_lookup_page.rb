class GeneralLedgerPendingEntryLookupPage < Lookups

  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }

  element(:ledger_document_type)  { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:origin_code) { |b| b.frm.text_field(name: 'financialSystemOriginationCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:document_number) { |b| b.frm.text_field(name: 'documentNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  element(:organization_document_number) { |b| b.frm.text_field(name: 'organizationDocumentNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'financialObjectCode') }
  element(:project_code) { |b| b.frm.text_field(name: 'projectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'financialSubObjectCode') }
  element(:organization_reference_id) { |b| b.frm.text_field(name: 'organizationReferenceId') }
  element(:balance_type_code) { |b| b.frm.text_field(name: 'financialBalanceTypeCode') }
  element(:reference_document_type_code) { |b| b.frm.text_field(name: 'referenceFinancialDocumentTypeCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'financialObjectTypeCode') }
  element(:reference_origin_code) { |b| b.frm.text_field(name: 'referenceFinancialSystemOriginationCode') }
  element(:fiscal_period) { |b| b.frm.text_field(name: 'universityFiscalPeriodCode') }
  element(:reference_document_number) { |b| b.frm.text_field(name: 'referenceFinancialDocumentNumber') }

  element(:pending_entry_approved) { |b| b.frm.radio(id: 'documentHeader.financialDocumentStatusCodeApproved') }
  element(:pending_entry_all) { |b| b.frm.radio(id: 'documentHeader.financialDocumentStatusCodeAll') }

  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
  action(:search_ledger_document_type) { |b| b.frm.button(title: 'Search Ledger Document Type').click }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_origin_code) { |b| b.frm.button(title: 'Search Origin Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }
  action(:search_object_code) { |b| b.frm.button(title: 'Search Object Code').click }
  action(:search_project_code) { |b| b.frm.button(title: 'Search Project Code').click }
  action(:search_sub_object_code) { |b| b.frm.button(title: 'Search Sub-Object Code').click }
  action(:search_balance_type_code) { |b| b.frm.button(title: 'Search Balance Type Code').click }
  action(:search_reference_document_type_code) { |b| b.frm.button(title: 'Search Reference Document Type Code').click }
  action(:search_object_type_code) { |b| b.frm.button(title: 'Search Object Type Code').click }
  action(:search_reference_origin_code) { |b| b.frm.button(title: 'Search Reference Origin Code').click }
  action(:search_fiscal_period) { |b| b.frm.button(title: 'Search Fiscal Period').click }

end #Class
