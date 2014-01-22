class PreEncumbrancePage < BasePage
  page_url "#{$base_url}portal.do?channelTitle=Pre-Encumbrance&channelUrl=financialPreEncumbrance.do?methodToCall=docHandler&command=initiate&docTypeName=PE"

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:accounting_lines) { |b| b.frm.div(id: 'tab-AccountingLines-div').table(class: 'datatable') }

  #writeable_elements
  element(:encumbrance_reversal_date) { |b| b.frm.text_field(name: 'document.reversalDate') }
  element(:encumbrance_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:encumbrance_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:encumbrance_sub_account) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:encumbrance_object) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:encumbrance_sub_object) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:encumbrance_project) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:encumbrance_org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:encumbrance_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  element(:encumbrance_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
  element(:encumbrance_auto_disencumber_type) { |b| b.frm.select(name: 'newSourceLine.autoDisEncumberType') }
  element(:encumbrance_start_date) { |b| b.frm.text_field(name: 'newSourceLine.startDate') }
  element(:encumbrance_count) { |b| b.frm.text_field(name: 'newSourceLine.partialTransactionCount') }
  element(:encumbrance_partial_amount) { |b| b.frm.text_field(name: 'newSourceLine.partialAmount') }

  element(:disencumbrance_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }
  element(:disencumbrance_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
  element(:disencumbrance_sub_account) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
  element(:disencumbrance_object) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
  element(:disencumbrance_sub_object) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
  element(:disencumbrance_project) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
  element(:disencumbrance_org_ref_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
  element(:disencumbrance_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }
  element(:disencumbrance_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
  element(:disencumbrance_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }

  action(:add_encumbrance) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
  action(:add_disencumbrance) { |b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }

  #readonly_elements
  action(:encumbrance_reference_number) { |offset, b| b.frm.span(:id, "document.sourceAccountingLine[#{offset}].referenceNumber.div").text }
  element(:first_encumbrance_reference_number) { |b| b.encumbrance_reference_number(0) }

end