class BtLedgerBalanceLookupPage < LedgerBalanceLookupPage

  account_facets
  subaccount_facets

  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_number) { |b| b.frm.button(title: 'Search Sub-Account Number').click }

end
