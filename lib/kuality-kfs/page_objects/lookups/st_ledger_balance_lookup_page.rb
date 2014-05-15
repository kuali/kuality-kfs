class StLedgerBalanceLookupPage < LedgerBalanceLookupPage

  element(:chart_code) { |b| b.frm.text_field(name: 'emplid') }
  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Employee ID').click }

end
