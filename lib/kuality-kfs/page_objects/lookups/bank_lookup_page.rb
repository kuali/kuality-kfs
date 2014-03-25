class BankLookupPage < Lookups

  element(:bank_code) { |b| b.frm.text_field(name: 'bankCode') }
  element(:bank_name) { |b| b.frm.text_field(name: 'bankName') }
  element(:bank_account_number) { |b| b.frm.text_field(name: 'bankAccountNumber') }
  element(:bank_account_description) { |b| b.frm.text_field(name: 'bankAccountDescription') }
  element(:cash_offset_chart_code) { |b| b.frm.text_field(name: 'cashOffsetFinancialChartOfAccountCode') }
  element(:cash_offset_account_number) { |b| b.frm.text_field(name: 'cashOffsetAccountNumber') }
  element(:cash_offset_sub_account_number) { |b| b.frm.text_field(name: 'cashOffsetSubAccountNumber') }
  element(:cash_offset_object_code) { |b| b.frm.text_field(name: 'cashOffsetObjectCode') }
  element(:cash_offset_sub_object_code) { |b| b.frm.text_field(name: 'cashOffsetSubObjectCode') }
  element(:bank_deposit_ind) { |b| b.frm.radio(name: 'bankDepositIndicator') }
  element(:bank_disb_ind) { |b| b.frm.radio(name: 'bankDisbursementIndicator') }

end
