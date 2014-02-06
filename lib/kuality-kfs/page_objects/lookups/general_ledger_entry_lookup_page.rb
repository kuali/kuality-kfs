class GeneralLedgerEntryLookupPage < Lookups

  document_facets
  fiscal_officer_facets
  account_facets
  subaccount_facets
  financial_object_facets
  reference_document_facets

  element(:pending_entry_approved_indicator) { |b| b.frm.radios(name: 'dummyBusinessObject.pendingEntryOption') }
  element(:debit_credit_view) { |b| b.frm.radios(name: 'dummyBusinessObject.debitCreditOption') }

  action(:pending_entry_approved_indicator_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll').set }
  action(:pending_entry_approved_indicator_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo').set }
  action(:pending_entry_approved_indicator_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved').set }
  action(:debit_credit_view_include) { |b| b.frm.radio(id: 'dummyBusinessObject.debitCreditOptionInclude').set }
  action(:debit_credit_view_exclude) { |b| b.frm.radio(id: 'dummyBusinessObject.debitCreditOptionExclude').set }


  action(:find_preencumbrance_doc) do |pe, b|
    # We'll assume that fiscal year and fiscal period default to nowish
    b.chart_code.fit pe.encumbrance_chart_code
    b.account_number.fit pe.encumbrance_account_number
    b.balance_type_code.fit ''
    b.pending_entry_approved_indicator_all

    b.search

    # The description field gets truncated to 40 characters for this display. Joy.
    truncated_description = pe.description.length > 40 ? pe.description[0,39] : pe.description
    b.open_item_via_text(truncated_description, pe.document_id)
  end

    action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
    action(:search_document_type) { |b| b.frm.button(title: 'Search Document Type').click }
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

end