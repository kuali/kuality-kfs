class BenefitExpenseTransferPage < FinancialProcessingPage

  action(:import_search) { |b| b.frm.button(title: 'search', name: /methodToCall.performBalanceInquiryLookup/m).click }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }

  action(:copy_all_source_accounting_lines) { |l=0, b| b.frm.button(name: "methodToCall.copyAllAccountingLines").click }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }

end