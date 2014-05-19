class GeneralLedgerPendingEntryTab < FinancialProcessingPage
  value(:amount) { |i=0, b| b.frm.hidden(name: "document.generalLedgerPendingEntry[#{i}].transactionLedgerEntryAmount") }
  element(:glpe_tables) { |b| b.frm.tables(summary: 'view/edit pending entries') }
  element(:glpe_table) { |b| b.glpe_tables[b.glpe_tables.length - 1] }
  p_value(:amount_array) { |b| array = []; (0..b.glpe_table.rows.length - 2).each { |i| array << b.amount(i).value}; array }
end
