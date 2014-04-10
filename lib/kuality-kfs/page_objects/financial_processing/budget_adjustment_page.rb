class BudgetAdjustmentPage < FinancialProcessingPage

  financial_document_detail
  accounting_lines

  ad_hoc_recipients

  # Financial Document Detail
  element(:fdd_year) { |b| b.frm.select(name: 'document.postingYear') }
  action(:fdd_refresh) { |b| b.frm.button(class: 'tinybutton', name: 'methodToCall.refresh').click }

  # Viewing document without editing ability to locate values
  value(:find_source_amount) { |level='0', b| b.frm.span(id: "document.sourceAccountingLine[#{level}].currentBudgetAdjustmentAmount.div").text }
  value(:find_target_amount) { |level='0', b| b.frm.span(id: "document.targetAccountingLine[#{level}].currentBudgetAdjustmentAmount.div").text }

  value(:find_source_line_description) { |level='0', b| b.frm.span(id: "document.sourceAccountingLine[#{level}].financialDocumentLineDescription.div").text }
  value(:find_target_line_description) { |level='0', b| b.frm.span(id: "document.targetAccountingLine[#{level}].financialDocumentLineDescription.div").text }
end