class AccountDelegateModelLookupPage < Lookups

  element(:chart_of_accounts_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:account_delegate_model_name) { |b| b.frm.text_field(name: 'accountDelegateModelName') }
  element(:active_indicator) { |b| b.frm.radios(name: 'active') }
  element(:active_indicator_yes) { |b| b.frm.radio(title: 'Active Indicator - Yes') }
  element(:active_indicator_no) { |b| b.frm.radio(title: 'Active Indicator - No') }
  element(:active_indicator_both) { |b| b.frm.radio(title: 'Active Indicator - Both') }
  action(:edit_account_delegate_model) { |coa_code, org_code, adm_name, b| b.frm.link(title: "edit Account Delegate Model with Organization Code=#{org_code} Chart Of Accounts Code=#{coa_code} Account Delegate Model Name=#{adm_name} ").click }
end