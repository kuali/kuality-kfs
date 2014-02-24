class NonCheckDisbursementPage < FinancialProcessingPage

  document_overview
  financial_document_detail
  accounting_lines_from_to

  element(:bank_code) { |b| b.frm.text_field(id: 'document.financialDocumentBankCode') }
  value(:bank_code_full) { |b| b.frm.table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text }

end
