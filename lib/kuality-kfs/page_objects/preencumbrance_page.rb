class PreEncumbrancePage < BasePage
  page_url "#{$base_url}portal.do?channelTitle=Pre-Encumbrance&channelUrl=financialPreEncumbrance.do?methodToCall=docHandler&command=initiate&docTypeName=PE"

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:reversal_date) { |b| b.frm.text_field(name: 'document.reversalDate') }
  element(:accounting_lines) { |b| b.frm.div(id: 'tab-AccountingLines-div').table(class: 'datatable') }
  element(:chart_code) { |b| b.accounting_lines.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:account_number) { |b| b.accounting_lines.text_field(name: 'newSourceLine.accountNumber') }
  element(:sub_account) { |b| b.accounting_lines.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:object) { |b| b.accounting_lines.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:sub_object) { |b| b.accounting_lines.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:project) { |b| b.accounting_lines.text_field(name: 'newSourceLine.projectCode') }
  element(:org_ref_id) { |b| b.accounting_lines.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:line_description) { |b| b.accounting_lines.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
  element(:amount) { |b| b.accounting_lines.text_field(name: 'newSourceLine.amount') }
  element(:auto_disencumber_type) { |b| b.accounting_lines.select(name: 'newSourceLine.autoDisEncumberType') }
  element(:start_date) { |b| b.accounting_lines.text_field(name: 'newSourceLine.startDate') }
  element(:count) { |b| b.accounting_lines.text_field(name: 'newSourceLine.partialTransactionCount') }
  element(:partial_amount) { |b| b.accounting_lines.text_field(name: 'newSourceLine.partialAmount') }

end