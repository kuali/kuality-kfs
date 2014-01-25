class AdvanceDepositPage < KFSBasePage

  element(:new_deposit_date) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDate') }
  element(:new_deposit_ref_number) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositReferenceNumber') }
  element(:new_deposit_description) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDescription') }
  element(:new_deposit_amount) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositAmount') }
  action(:add_deposit) { |b| b.frm.button(name: 'methodToCall.addAdvanceDeposit').click }

  element(:new_account_chart) { |b| b.frm.text_field(name: 'newSourceLine.chartOfAccountsCode') }
  element(:new_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:new_account_sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:new_account_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:new_account_sub_object) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:new_account_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:new_account_org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:new_account_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
  element(:new_account_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  action(:add_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }

  element(:accounting_lines_for_capitalization_select) { |line, p| p.frm.checkbox(id: 'document.capitalAccountingLines[#{line}.selectLine') }
  action(:modify_asset) { |b| b.frm.button(name: 'methodToCall.modifyAsset').click }
  action(:redistribute_capital_asset_amount) { |b| b.frm.button(name: 'methodToCall.redistributeModifyCapitalAssetAmount').click }

end