class DisbursementVoucherPage < FinancialProcessingPage


  document_overview
  accounting_lines_from_to

  notes_and_attachments
  ad_hoc_recipients


  element(:contact_name) { |b| b.frm.text_field(id: 'document.disbVchrContactPersonName') }
  element(:phone_number) { |b| b.frm.text_field(id: 'document.disbVchrContactPhoneNumber') }
  element(:email_address) { |b| b.frm.text_field(id: 'document.disbVchrContactEmailId') }

  value(:bank_code) { |b| b.frm.table(summary: 'Advance Deposits').td(class: 'infoline').text }
  value(:bank_code_full) { |b| b.frm.table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text }
end