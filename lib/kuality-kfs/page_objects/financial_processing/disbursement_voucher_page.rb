class DisbursementVoucherPage < FinancialProcessingPage

  document_overview
  financial_document_detail
  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients

#financial_document_detail
  value(:bank_code) { |b| b.frm.table(summary: 'Advance Deposits').td(class: 'infoline').text }

  value(:bank_code_full) { |b| b.frm.table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text }

  element(:contact_name) { |b| b.frm.text_field(id: 'document.disbVchrContactPersonName') }
  element(:phone_number) { |b| b.frm.text_field(id: 'document.disbVchrContactPhoneNumber') }
  element(:email_address) { |b| b.frm.text_field(id: 'document.disbVchrContactEmailId') }

#        #returns  "DISB\nMellon Controlled Disbursement Account "
#  value(:bank_code_bank_text) { |b| b.frm.table(summary: 'KFS Detail Section').div(id: 'document.bank.div').text }
#        #returns "Mellon Controlled Disbursement Account "
end