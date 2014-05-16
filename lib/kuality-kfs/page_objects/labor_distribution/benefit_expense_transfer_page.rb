class BenefitExpenseTransferPage < LaborDistributionPage

  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }

end