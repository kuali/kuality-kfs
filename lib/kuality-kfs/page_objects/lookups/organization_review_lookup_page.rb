class OrganizationReviewLookupPage < Lookups

  element(:doc_type) { |b| b.frm.hidden(name: 'financialSystemDocumentTypeCode') }
  element(:chart_code) { |b| b.frm.select(name: 'chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:principal_name) { |b| b.frm.text_field(name: 'principalMemberPrincipalName') }
  element(:namespace) { |b| b.frm.select(name: 'roleMemberRoleNamespaceCode') }
  element(:role_name) { |b| b.frm.select(name: 'roleMemberRoleName') }
  element(:group_namespace) { |b| b.frm.select(name: 'groupMemberGroupNamespaceCode') }
  element(:group_name) { |b| b.frm.text_field(name: 'groupMemberGroupName') }
  element(:delegate) { |b| b.frm.radio(name: 'delegate') }
  element(:active_indicator) { |b| b.frm.radio(name: 'active') }

end