class IndirectCostAdjustmentPage < FinancialProcessingPage

  financial_document_detail
  accounting_lines
  ad_hoc_recipients

#accounting_lines_grant_reciept
  #GRANT
  element(:grant_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:grant_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:grant_sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  value(:grant_object_code) { |b| b.frm.span(id: 'newSourceLine.financialObjectCode.div').text }

  element(:grant_sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:grant_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:grant_organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:grant_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
  element(:grant_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }

  action(:add_grant_accounting_line) { |b| b.frm.button(alt: 'Add Grant Accounting Line').click }
  #RECEIPT
  element(:receipt_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }
  element(:receipt_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
  element(:receipt_sub_account_number) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
  value(:receipt_object_code) { |b| b.frm.span(id: 'newTargetLine.financialObjectCode.div').text }

  element(:receipt_sub_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
  element(:receipt_project_code) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
  element(:receipt_organization_reference_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
  element(:receipt_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
  element(:receipt_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }

  action(:add_receipt_accounting_line) { |b| b.frm.button(alt: 'Add Receipt Accounting Line').click }
end
