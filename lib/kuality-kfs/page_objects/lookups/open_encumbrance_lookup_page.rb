class OpenEncumbranceLookupPage < Lookups

  document_facets
  account_facets
  subaccount_facets
  fiscal_year_facets
  encumbrance_object_facets

  element(:object_code) { |b| b.frm.text_field(name: 'objectCode') }
  element(:balance_type_code) { |b| b.frm.text_field(id: 'balanceTypeCode') }

  element(:active_indicator_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo') }
  element(:active_indicator_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved') }
  element(:active_indicator_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll') }

  element(:including_pending_ledger_entry_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo') }
  element(:including_pending_ledger_entry_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved') }
  element(:including_pending_ledger_entry_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll') }

  element(:including_zeroed_out_encumbrances_include) { |b| b.frm.radio(id: 'dummyBusinessObject.zeroEncumbranceOptionInclude') }
  element(:including_zeroed_out_encumbrances_exclude) { |b| b.frm.radio(id: 'dummyBusinessObject.zeroEncumbranceOptionExclude') }

end