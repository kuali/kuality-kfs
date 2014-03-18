class AccountDelegatePage < KFSBasePage

  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountNumber') }
  element(:doc_type_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialDocumentTypeCode') }
  element(:principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountDelegate.principalName') }
  element(:approval_from_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.finDocApprovalFromThisAmt') }
  element(:approval_to_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.finDocApprovalToThisAmt') }
  element(:primary_route) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.accountsDelegatePrmrtIndicator') }
  element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountDelegateStartDate') }

end