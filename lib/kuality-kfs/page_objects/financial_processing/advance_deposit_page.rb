class AdvanceDepositPage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

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


#
#
#Credit Card Receipt
#Disbursement Voucher
#Distribution of Income and Expense

#General Error Correction
#Indirect Cost Adjustment
#Internal Billing
#Intra-Account Adjustment
#Pre-Encumbrance
#Transfer of Funds


  class AdvancedDepositPage < FinancialProcessingPage

    document_overview

#financial_document_detail
    value(:total_amount) { |b| b.frm.table(summary: 'KFS Detail Section').td(align: 'left').text }
#advanced_deposits
    value(:bank_code) { |b| b.frm.table(summary: 'Advance Deposits').td(class: 'infoline').text }
    element(:adv_deposit_date) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDate') }
    element(:adv_deposit_reference_number) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositReferenceNumber') }
    element(:adv_deposit_description) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDescription') }
    element(:adv_deposit_amount) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositAmount') }
    action(:add_an_advance_deposit) { |b| b.frm.button(title: 'Add an Advance Deposit').click }

#accounting_lines
    #add
    element(:chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }





    action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
    action(:search_sub_account) { |b| b.frm.button(title: 'Search Sub-Account').click }
    action(:search_object) { |b| b.frm.button(title: 'Search Object').click }
    action(:search_sub_object) { |b| b.frm.button(title: 'Search Sub-Object').click }
    action(:search_project) { |b| b.frm.button(title: 'Search Project').click }

  end

end

