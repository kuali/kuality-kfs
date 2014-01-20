class SubAccountPage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subAccountNumber') }
  element(:name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subAccountName') }
  element(:type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.subAccountTypeCode') }


  element(:sub_account_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.a21SubAccount.subAccountTypeCode') }


  #Edit CG Cost Sharing
  element(:cost_sharing_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.a21SubAccount.costShareChartOfAccountCode') }
  element(:cost_sharing_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.costShareSourceAccountNumber') }
  element(:cost_sharing_sub_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.costShareSourceSubAccountNumber') }


  element(:icr_identifier) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.financialIcrSeriesIdentifier') }


  #Ad Hoc Recipients
  element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  action(:ad_hoc_person_add) { |b| b.frm.button(name: 'methodToCall.insertAdHocRoutePerson').click }

end