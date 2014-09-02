class OrganizationReviewPage < KFSBasePage

  element(:chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:doc_type) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialSystemDocumentTypeCode') }
  element(:review_types) { |b| b.frm.radio(name: 'document.newMaintainableObject.reviewRolesIndicator') }
  element(:from_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.fromAmount') }
  element(:to_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.toAmount') }
  element(:accounting_line_override_code) { |b| b.frm.select(name: 'document.newMaintainableObject.overrideCode') }
  element(:principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.principalMemberPrincipalName') }
  element(:namespace) { |b| b.frm.select(name: 'document.newMaintainableObject.roleMemberRoleNamespaceCode') }
  element(:role_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.roleMemberRoleName') }
  element(:group_namespace) { |b| b.frm.select(name: 'document.newMaintainableObject.groupMemberGroupNamespaceCode') }
  element(:group_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.groupMemberGroupName') }
  element(:action_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.actionTypeCode') }
  element(:priority_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.priorityNumber') }
  element(:action_policy_code) { |b| b.frm.select(name: 'document.newMaintainableObject.actionPolicyCode') }
  element(:force_action) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.forceAction') }
  element(:action_from_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.activeFromDate') }
  element(:action_to_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.activeToDate') }

  action(:document_type_search) { |b| b.frm.button(title: 'Search Document Type').click }
  action(:principal_search) { |b| b.frm.button(title: 'Search Principal Name').click }

end