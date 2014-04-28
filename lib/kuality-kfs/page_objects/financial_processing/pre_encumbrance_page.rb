class PreEncumbrancePage < FinancialProcessingPage

  financial_document_detail
  accounting_lines
  ad_hoc_recipients

  #pre_encumbrance_details
   element(:reversal_date) { |b| b.frm.text_field(name: 'document.reversalDate') }

  #accounting_lines_encumbrance_disencumbrance
  #ENCUMBRANCE
  element(:encumbrance_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:encumbrance_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:encumbrance_sub_account) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:encumbrance_object) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:encumbrance_sub_object) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:encumbrance_project) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:encumbrance_org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:encumbrance_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
  element(:encumbrance_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  element(:encumbrance_auto_disencumber_type) { |b| b.frm.select(name: 'newSourceLine.autoDisEncumberType') }
  element(:encumbrance_count) { |b| b.frm.text_field(name: 'newSourceLine.partialTransactionCount') }
  element(:encumbrance_start_date) { |b| b.frm.text_field(name: 'newSourceLine.startDate') }
  element(:encumbrance_partial_amount) { |b| b.frm.text_field(name: 'newSourceLine.partialAmount') }

  action(:add_encumbrance_line) { |b| b.frm.button(alt: 'Add Encumbrance Accounting Line').click }
  #DISENCUMBRANCE
  element(:disencumbrance_chart_code) { |b| b.select(name: 'newTargetLine.chartOfAccountsCode') }
  element(:disencumbrance_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
  element(:disencumbrance_sub_account) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
  element(:disencumbrance_object) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
  element(:disencumbrance_sub_object) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
  element(:disencumbrance_project) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
  element(:disencumbrance_org_ref_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
  alias_method :disencumbrance_organization_reference_id, :disencumbrance_org_ref_id

  element(:disencumbrance_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
  element(:disencumbrance_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }
  element(:disencumbrance_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }

  action(:add_disencumbrance_line) { |b| b.frm.button(alt: 'Add Disencumbrance Accounting Line').click }
end
