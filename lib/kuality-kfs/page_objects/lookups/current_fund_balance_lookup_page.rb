class CurrentFundBalanceLookupPage < Lookups

  document_facets

  element(:chart_code) { |b| b.frm.text_field(id: 'account.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(id: 'account.accountNumber') }

end