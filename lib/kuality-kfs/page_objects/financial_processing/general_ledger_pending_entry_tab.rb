class GeneralLedgerPendingEntryTab < FinancialProcessingPage
  value(:amount) { |i=0, b| b.frm.hidden(name: "document.generalLedgerPendingEntry[#{i}].transactionLedgerEntryAmount") }
  element(:glpe_table) { |b| b.frm.table(summary: 'view/edit pending entries') }
  p_value(:amount_array) { |b| array = []; (0..b.glpe_table.rows.length - 2).each { |i| array << b.amount(i).value}; array }
end
