class OpenEncumbranceLookupPage < Lookups

  element(:year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:sub_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'objectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'subObjectCode') }
  element(:balance_type) { |b| b.frm.text_field(name: 'balanceTypeCode') }
  element(:doc_type) { |b| b.frm.text_field(name: 'documentTypeCode') }
  element(:origin_code) { |b| b.frm.text_field(name: 'originCode') }
  element(:doc_number) { |b| b.frm.text_field(name: 'documentNumber') }
  element(:include_pending_ledger_entry) { |b| b.frm.radio(name: 'dummyBusinessObject.pendingEntryOption') }
  element(:include_zeroed_out_encumbrances) { |b| b.frm.radio(name: 'dummyBusinessObject.zeroEncumbranceOption') }

end