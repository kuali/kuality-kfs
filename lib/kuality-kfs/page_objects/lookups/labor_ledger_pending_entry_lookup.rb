class LaborLedgerPendingEntryLookupPage < Lookups

  element(:empl_id) { |b| b.frm.text_field(name: 'emplid') }
  action(:fiscal_year) { |b| b.frm.select(id: 'universityFiscalPeriodCode') }

end
