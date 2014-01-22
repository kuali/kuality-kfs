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

end