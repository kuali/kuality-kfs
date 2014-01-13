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

  element(:icr_identifier) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.financialIcrSeriesIdentifier') }

end