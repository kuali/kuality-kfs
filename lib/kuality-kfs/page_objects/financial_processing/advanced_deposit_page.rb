


Credit Card Receipt
Disbursement Voucher
Distribution of Income and Expense
General Error Correction
Indirect Cost Adjustment
Internal Billing
Intra-Account Adjustment
Pre-Encumbrance
Transfer of Funds


class AdvancedDepositPage < BasePage

element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
element(:adv_deposit_date) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDate') }
element(:adv_deposit_reference_number) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositReferenceNumber') }
element(:adv_deposit_description) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositDescription') }
element(:adv_deposit_amount) { |b| b.frm.text_field(name: 'newAdvanceDeposit.financialDocumentAdvanceDepositAmount') }

element(:chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }

element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
element(:sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
element(:object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
element(:sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
element(:project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
element(:org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
element(:amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }

element(:line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
element(:note_text) { |b| b.frm.text_field(name: 'newNote.noteText') }
element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
element(:ad_hoc_name_space_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
element(:ad_hoc_group_name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }

element(:ad_hoc_action_requested) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
element(:ad_hoc_group_action_requested) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }

action(:add_an_advance_deposit) { |b| b.frm.button(title: 'Add an Advance Deposit').click }

action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
action(:search_sub_account) { |b| b.frm.button(title: 'Search Sub-Account').click }
action(:search_object) { |b| b.frm.button(title: 'Search Object').click }
action(:search_sub_object) { |b| b.frm.button(title: 'Search Sub-Object').click }
action(:search_project) { |b| b.frm.button(title: 'Search Project').click }

action(:add__accounting_line) { |b| b.frm.button(title: 'Add  Accounting Line').click }

action(:add_a_note) { |b| b.frm.button(title: 'Add a Note').click }

action(:insert_additional_ad_hoc_person) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Person').click }

action(:insert_additional_ad_hoc_workgroup) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Workgroup').click }

end
