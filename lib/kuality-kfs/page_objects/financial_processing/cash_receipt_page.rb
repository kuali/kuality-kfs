class CashReceiptPage < FinancialProcessingPage

  financial_document_detail
  accounting_lines

  ad_hoc_recipients

#cash_reconciliation
  element(:total_check_amount) {|b| b.frm.select(name: 'document.checkEntryMode') }
  action(:recalculate) { |b| b.frm.button(title: 'recalculate total').click }

#currency_and_coin_detail
  element(:hundred_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.hundredDollarCount') }
  element(:hundred_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.hundredCentCount') }
  element(:fifty_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.fiftyDollarCount') }
  element(:fifty_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.fiftyCentCount') }
  element(:twenty_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.twentyDollarCount') }
  element(:twenty_five_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.twentyFiveCentCount') }
  element(:ten_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.tenDollarCount') }
  element(:ten_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.tenCentCount') }
  element(:five_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.fiveDollarCount') }
  element(:five_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.fiveCentCount') }
  element(:two_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.twoDollarCount') }
  element(:one_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.oneCentCount') }
  element(:one_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.oneDollarCount') }
  element(:other_cent_amount) { |b| b.frm.text_field(name: 'document.coinDetail.financialDocumentOtherCentAmount') }
  element(:other_dollar_amount) { |b| b.frm.text_field(name: 'document.currencyDetail.financialDocumentOtherDollarAmount') }

#check_detaiil
  element(:check_number) { |b| b.frm.text_field(name: 'newCheck.checkNumber') }
  element(:check_date) { |b| b.frm.text_field(name: 'newCheck.checkDate') }
  element(:check_description) { |b| b.frm.text_field(name: 'newCheck.description') }
  element(:check_amount) { |b| b.frm.text_field(name: 'newCheck.amount') }
  action(:add_check_detail) { |b| b.frm.button(name: 'methodToCall.addCheck').click }

#accounting_lines_for_capitalization

#modify_capital_assets
end