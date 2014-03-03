class JournalVoucherPage < FinancialProcessingPage

  # FIXME: Review these includes and remove any unneeded ones.
  document_overview
  financial_document_detail
  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients

  element(:accounting_period) { |b| b.frm.select(name: 'selectedAccountingPeriod') }
  element(:balance_type_code) { |b| b.frm.select(name: 'selectedBalanceType.code') }
  element(:reversal_date) { |b| b.frm.text_field(id: 'document.reversalDate') }

end