class AuxiliaryVoucherPage < FinancialProcessingPage

 #ACCOUNTING LINES
 #ON FPPAGE

  element(:debit) { |b| b.frm.text_field(name: 'newSourceLineDebit') }
  element(:credit) { |b| b.frm.text_field(name: 'newSourceLineCredit') }

  element(:accounting_period) { |b| b.frm.select(name: 'selectedAccountingPeriod') }
  element(:chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }

  #ADHOC
  #ON FPPAGE

  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_code) { |b| b.frm.button(title: 'Search Sub-Account Code').click }
  action(:search_object_code) { |b| b.frm.button(title: 'Search Object Code').click }
  action(:search_sub_object_code) { |b| b.frm.button(title: 'Search Sub-Object Code').click }
  action(:search_project_code) { |b| b.frm.button(title: 'Search Project Code').click }


end