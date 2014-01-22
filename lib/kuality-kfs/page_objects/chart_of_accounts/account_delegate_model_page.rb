class AccountDelegateModelPage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages
  route_log

  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:org_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:account_delegate_model_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountDelegateModelName') }
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

  element(:document_type_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.financialDocumentTypeCode') }
  element(:account_delegate_primary_route) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.accountDelegatePrimaryRoutingIndicator') }
  element(:account_delegate_start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.accountDelegateStartDate') }
  element(:approval_from_this_account) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.approvalFromThisAmount') }
  element(:approval_to_this_account) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.approvalToThisAmount') }
  element(:account_delegate_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.accountDelegate.principalName') }
  element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.accountDelegateModelDetails.active') }

end