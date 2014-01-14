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

end