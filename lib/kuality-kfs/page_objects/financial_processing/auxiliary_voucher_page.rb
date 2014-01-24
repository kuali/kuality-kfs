class AuxiliaryVoucherPage < BasePage

  element(:explaination) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
  element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }

  element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:sub_account_code) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:project_code) { |b| b.frm. ext_field(name: 'newSourceLine.projectCode') }
  element(:organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:debit) { |b| b.frm.text_field(name: 'newSourceLineDebit') }
  element(:credit) { |b| b.frm.text_field(name: 'newSourceLineCredit') }
  element(:line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  element(:note_text) { |b| b.frm.text_field(name: 'newNote.noteText') }
  element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  element(:ad_hoc_name_space_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
  element(:ad_hoc_group_name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }

  element(:accounting_period) { |b| b.frm.select(name: 'selectedAccountingPeriod') }
  element(:chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:ad_hoc_action_requested) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
  element(:ad_hoc_group_action_requested) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }

  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_sub_account_code) { |b| b.frm.button(title: 'Search Sub-Account Code').click }
  action(:search_object_code) { |b| b.frm.button(title: 'Search Object Code').click }
  action(:search_sub_object_code) { |b| b.frm.button(title: 'Search Sub-Object Code').click }
  action(:search_project_code) { |b| b.frm.button(title: 'Search Project Code').click }

  action(:add__accounting_line) { |b| b.frm.button(title: 'Add  Accounting Line').click }

  action(:add_a_note) { |b| b.frm.button(title: 'Add a Note').click }

  action(:insert_additional_ad_hoc_person) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Person').click }

  action(:insert_additional_ad_hoc_workgroup) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Workgroup').click }

end