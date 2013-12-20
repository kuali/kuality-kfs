class AccountDelegateModelLookupPage < Lookups

  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:org_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:name) { |b| b.frm.text_field(name: 'accountDelegateModelName') }
  element(:active_indicator) { |b| b.frm.radio(name: 'active') }

end