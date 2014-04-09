class JournalVoucherPage < FinancialProcessingPage

  # FIXME: Review these includes and remove any unneeded ones.
  financial_document_detail
  accounting_lines
  ad_hoc_recipients

  element(:reversal_date) { |b| b.frm.text_field(name: 'document.reversalDate') }
  element(:accounting_period) { |b| b.frm.select(name: 'selectedAccountingPeriod') }
  element(:balance_type_code) { |b| b.frm.text_field(name: 'selectedBalanceType.code') }

end