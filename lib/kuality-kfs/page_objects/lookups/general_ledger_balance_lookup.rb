class GeneralLedgerBalanceLookupPage < Lookups

  #search_results_table

  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'objectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'subObjectCode') }
  element(:balance_type_code) { |b| b.frm.text_field(name: 'balanceTypeCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'objectTypeCode') }
  element(:consolidation_option) { |b| b.frm.text_field(name: 'dummyBusinessObject.consolidationOption') }
  element(:amount_view_option) { |b| b.frm.text_field(name: 'dummyBusinessObject.amountViewOption') }

  element(:consolidation_option_consolidation) { |b| b.frm.radio(id: 'dummyBusinessObject.consolidationOptionConsolidation') }
  element(:consolidation_option_detail) { |b| b.frm.radio(id: 'dummyBusinessObject.consolidationOptionDetail') }
  element(:consolidation_option_exclude_sub_accounts) { |b| b.frm.radio(id: 'dummyBusinessObject.consolidationOptionExclude Sub-Accounts') }
  element(:amount_view_option_monthly) { |b| b.frm.radio(id: 'dummyBusinessObject.amountViewOptionMonthly') }
  element(:amount_view_option_accumulate) { |b| b.frm.radio(id: 'dummyBusinessObject.amountViewOptionAccumulate') }
  element(:including_pending_ledger_entry_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo') }
  element(:including_pending_ledger_entry_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved') }
  element(:including_pending_ledger_entry_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll') }

  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }
  action(:search_object_code) { |b| b.frm.button(title: 'Search Object Code').click }
  action(:search_sub_object_code) { |b| b.frm.button(title: 'Search Sub-Object Code').click }
  action(:search_balance_type_code) { |b| b.frm.button(title: 'Search Balance Type Code').click }
  action(:search_object_type_code) { |b| b.frm.button(title: 'Search Object Type Code').click }



  #JULY = 01
  #AUGUST = 02
  #SEPTEMBER = 03
  #OCTOBER = 04
  #NOVEMBER = 05
  #DECEMBER = 06
  #JANUARY = 07
  #FEBRUARY = 08
  #MARCH = 09
  #APRIL = 10
  #MAY = 11
  #JUNE = 12

end
