class AccountDelegateModelPage < BasePage

  #TODO: Kyle and Todd can discuss these in detail reason for these.
  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:chart_of_accounts_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:adm_name) { |b| b.frm.text_field(name: 'accountDelegateModelName') }

  element(:active_indicator_yes) { |b| b.frm.radio(title: 'Active Indicator - Yes') }
  element(:active_indicator_no) { |b| b.frm.radio(title: 'Active Indicator - No') }
  element(:active_indicator_both) { |b| b.frm.radio(title: 'Active Indicator - Both') }

  action(:edit_account_delegate_model) { |coa_code, org_code, adm_name, b| b.frm.link(title: "edit Account Delegate Model with Organization Code=#{org_code} Chart Of Accounts Code=#{coa_code} Account Delegate Model Name=#{adm_name} ").click }

  action(:yes_account_delegate_model) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0').when_present.click }
  #action(:no_account_delegate_model) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1').when_present.click }
end