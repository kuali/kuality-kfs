class BudgetAdjustmentPage < FinancialProcessingPage

  document_overview
  financial_document_detail
  accounting_lines

  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients

#Financial Document Detail
  element(:fdd_year) { |b| b.frm.select(name: 'document.postingYear') }
  action(:fdd_refresh) { |b| b.frm.button(class: 'tinybutton', name: 'methodToCall.refresh').click }

  #viewing document without editing ability to locate values
  value(:find_source_amount) { |level='0', b| b.frm.span(id: "document.sourceAccountingLine[#{level}].currentBudgetAdjustmentAmount.div").text }
  value(:find_target_amount) { |level='0', b| b.frm.span(id: "document.targetAccountingLine[#{level}].currentBudgetAdjustmentAmount.div").text }

  value(:find_source_line_description) { |level='0', b| b.frm.span(id: "document.sourceAccountingLine[#{level}].financialDocumentLineDescription.div").text }
  value(:find_target_line_description) { |level='0', b| b.frm.span(id: "document.targetAccountingLine[#{level}].financialDocumentLineDescription.div").text }

#For Uploading Documents
  action(:import_lines_from) {|b| b.frm.link(id: 'document.sourceAccountingLinesShowLink').click }
  action(:import_lines_to) {|b| b.frm.link(id: 'document.targetAccountingLinesShowLink').click }

  action(:add_from_import) { |b| b.frm.button(name: 'methodToCall.uploadSourceLines.document.sourceAccountingLines').click }
  action(:add_to_import) { |b| b.frm.button(name: 'methodToCall.uploadTargetLines.document.targetAccountingLines').click }

  element(:account_line_from_file_name) { |b| b.frm.div(id: 'uploaddocument.sourceAccountingLinesDiv').file_field(name: 'sourceFile') }
  element(:account_line_to_file_name) { |b| b.frm.div(id: 'uploaddocument.targetAccountingLinesDiv').file_field(name: 'targetFile') }
end