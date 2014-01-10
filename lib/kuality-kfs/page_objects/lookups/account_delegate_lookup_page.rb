class AccountDelegateLookupPage < Lookups

  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:document_type_name) { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }
  element(:account_delegate_principal_name) { |b| b.frm.text_field(name: 'accountDelegate.principalName') }

end