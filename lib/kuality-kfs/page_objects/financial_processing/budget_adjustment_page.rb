class BudgetAdjustmentPage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  #Document Overview
  #element(:description) { |b| b.frm.text_field(name: document.documentHeader.documentDescription) }
  element(:organization_document_number) { |b| b.frm.text_field(name: document.documentHeader.organizationDocumentNumber) }
  element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }

  #Financial Document Detail
  element(:fdd_year) { |b| b.frm.select(name: 'document.postingYear') }
  action(:fdd_refresh) { |b| b.frm.button(class: 'tinybutton', name: 'methodToCall.refresh').click }

  value(:total_amount) { |b| b.frm.table(summary: 'KFS Detail Section').td(align: 'left').text }

  #ACCOUNTING LINES FROM/DECREASE
  element(:from_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }

  element(:from_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:from_sub_account_code) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:from_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:from_sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:from_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:from_organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:from_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
  element(:from_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }
  element(:from_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  element(:from_month_1) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth1LineAmount') }
  element(:from_month_2) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth2LineAmount') }
  element(:from_month_3) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth3LineAmount') }
  element(:from_month_4) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth4LineAmount') }
  element(:from_month_5) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth5LineAmount') }
  element(:from_month_6) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth6LineAmount') }
  element(:from_month_7) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth7LineAmount') }
  element(:from_month_8) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth8LineAmount') }
  element(:from_month_9) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth9LineAmount') }
  element(:from_month_10) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth10LineAmount') }
  element(:from_month_11) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth11LineAmount') }
  element(:from_month_12) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth12LineAmount') }

  action(:add_from_accounting_line) { |b| b.frm.button(title: 'Add From/Decrease Accounting Line').click }

  #ACCOUNTING LINES TO/INCREASE
  element(:to_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }

  element(:to_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
  element(:to_sub_account_code) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
  element(:to_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
  element(:to_sub_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
  element(:to_project_code) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
  element(:to_organization_reference_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
  element(:to_current_amount) { |b| b.frm.text_field(name: 'newTargetLine.currentBudgetAdjustmentAmount') }
  element(:to_base_amount) { |b| b.frm.text_field(name: 'newTargetLine.baseBudgetAdjustmentAmount') }
  element(:to_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }
  element(:to_month_1) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth1LineAmount') }
  element(:to_month_2) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth2LineAmount') }
  element(:to_month_3) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth3LineAmount') }
  element(:to_month_4) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth4LineAmount') }
  element(:to_month_5) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth5LineAmount') }
  element(:to_month_6) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth6LineAmount') }
  element(:to_month_7) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth7LineAmount') }
  element(:to_month_8) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth8LineAmount') }
  element(:to_month_9) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth9LineAmount') }
  element(:to_month_10) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth10LineAmount') }
  element(:to_month_11) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth11LineAmount') }
  element(:to_month_12) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth12LineAmount') }

  action(:add_to_accounting_line) { |b| b.frm.button(title: 'Add To/Increase Accounting Line').click }

  #Notes and Attachments
  element(:note_text) { |b| b.frm.text_field(name: 'newNote.noteText') }
  action(:add_a_note) { |b| b.frm.button(title: 'Add a Note').click }

  #AD HOC
  element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  element(:ad_hoc_person_action_requested) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
  action(:add_ad_hoc_person) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Person').click }

  element(:ad_hoc_namespace_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
  element(:ad_hoc_name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }
  element(:ad_hoc_group_action_requested) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }
  action(:add_ad_hoc_group) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Workgroup').click }






end