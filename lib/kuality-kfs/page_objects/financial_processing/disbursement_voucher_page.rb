class DisbursementVoucherPage < FinancialProcessingPage


  document_overview
  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients

  element(:foreign_draft_in) { |v, b| b.frm.radio(name: 'document.dvWireTransfer.disbursementVoucherForeignCurrencyTypeCode', value: v) }
  element(:foreign_draft_in_usd) { |b| b.foreign_draft_in('C') }
  element(:foreign_draft_in_foreign_currency) { |b| b.foreign_draft_in('F') }
  element(:currency_type) { |b| b.frm.text_field(id: 'document.dvWireTransfer.disbursementVoucherForeignCurrencyTypeName') }

  element(:contact_name) { |b| b.frm.text_field(id: 'document.disbVchrContactPersonName') }
  element(:phone_number) { |b| b.frm.text_field(id: 'document.disbVchrContactPhoneNumber') }
  element(:email_address) { |b| b.frm.text_field(id: 'document.disbVchrContactEmailId') }

  value(:bank_code) { |b| b.frm.table(summary: 'Advance Deposits').td(class: 'infoline').text }
  value(:bank_code_full) { |b| b.frm.table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text }
#        #returns  "DISB\nMellon Controlled Disbursement Account "
#  value(:bank_code_bank_text) { |b| b.frm.table(summary: 'KFS Detail Section').div(id: 'document.bank.div').text }
#        #returns "Mellon Controlled Disbursement Account "
end