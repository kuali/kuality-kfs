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

#General Ledger Pending Entries






end