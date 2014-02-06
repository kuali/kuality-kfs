class BudgetAdjustmentPage < FinancialProcessingPage

  document_overview
  financial_document_detail
  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients

#Financial Document Detail
  element(:fdd_year) { |b| b.frm.select(name: 'document.postingYear') }
  action(:fdd_refresh) { |b| b.frm.button(class: 'tinybutton', name: 'methodToCall.refresh').click }

#General Ledger Pending Entries

  action(:from_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
  action(:from_base_amt_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].baseBudgetAdjustmentAmount") }

  action(:to_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }

end