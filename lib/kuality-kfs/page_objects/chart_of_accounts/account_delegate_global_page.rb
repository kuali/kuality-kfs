class AccountDelegateGlobalPage < KFSBasePage

  element(:doc_type) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.delegateGlobals.financialDocumentTypeCode') }
  element(:primary_route) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.delegateGlobals.accountDelegatePrimaryRoutingIndicator') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.delegateGlobals.accountDelegateStartDate') }
  element(:principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.delegateGlobals.accountDelegate.principalName') }
  action(:add_delegate) { |b| b.frm.button(name: /^methodToCall.addLine.delegateGlobals/).click }

  element(:chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.accountGlobalDetails.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountGlobalDetails.accountNumber') }
  action(:add_account) { |b| b.frm.button(name: /^methodToCall.addLine.accountGlobalDetails/).click }

end