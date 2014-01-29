#class GeneralLedgerEntryLookupPage < Lookups
#
#  #account_facets
#  document_facets
#  subaccount_facets
#  organization_facets
#  financial_object_facets
#  fiscal_year_facets
#  reference_document_facets
#  project_facets
#
#  element(:document_type) { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }
#
#  element(:pending_entry_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo') }
#  element(:pending_entry_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved') }
#  element(:pending_entry_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll') }
#  element(:debit_credit_view_include) { |b| b.frm.radio(id: 'dummyBusinessObject.debitCreditOptionInclude') }
#  element(:debit_credit_view_exclude) { |b| b.frm.radio(id: 'dummyBusinessObject.debitCreditOptionExclude') }
#
#  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
#  action(:search_document_type) { |b| b.frm.button(title: 'Search Document Type').click }
#  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
#  action(:search_origin_code) { |b| b.frm.button(title: 'Search Origin Code').click }
#  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
#  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }
#  action(:search_object_code) { |b| b.frm.button(title: 'Search Object Code').click }
#  action(:search_project_code) { |b| b.frm.button(title: 'Search Project Code').click }
#  action(:search_sub_object_code) { |b| b.frm.button(title: 'Search Sub-Object Code').click }
#  action(:search_balance_type_code) { |b| b.frm.button(title: 'Search Balance Type Code').click }
#  action(:search_reference_document_type_code) { |b| b.frm.button(title: 'Search Reference Document Type Code').click }
#  action(:search_object_type_code) { |b| b.frm.button(title: 'Search Object Type Code').click }
#  action(:search_reference_origin_code) { |b| b.frm.button(title: 'Search Reference Origin Code').click }
#  action(:search_fiscal_period) { |b| b.frm.button(title: 'Search Fiscal Period').click }
#
#end #class
