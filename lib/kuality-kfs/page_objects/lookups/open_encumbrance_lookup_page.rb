class OpenEncumbranceLookupPage < Lookups

  document_facets
  account_facets
  subaccount_facets
  fiscal_year_facets
  encumbrance_object_facets

  element(:balance_type_code) { |b| b.frm.text_field(id: 'balanceTypeCode') }

  element(:active_indicator_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo') }
  element(:active_indicator_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved') }
  element(:active_indicator_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll') }

end