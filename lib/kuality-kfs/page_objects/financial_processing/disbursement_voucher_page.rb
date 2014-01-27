class DisbursementVoucherPage < FinancialProcessingPage


  document_overview
  financial_document_detail
  accounting_lines

  notes_and_attachments
  ad_hoc_recipients



#financial_document_detail
  value(:bank_code_full)b.frame(id: /easyXDM_default\d+_provider/).frame(id: 'iframeportlet').table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text
        #returns  "DISB\nMellon Controlled Disbursement Account "
  value(:bank_code_bank_text){ |b| b.frm.table(summary: 'KFS Detail Section').div(id: 'document.bank.div').text }
        #returns "Mellon Controlled Disbursement Account "

  #payment_information



  #contact_information
  #special_handling
  #nonresident_alien_tax
  #wire_transfer
  #foreign_draft
  #non_employee_travel_expense
  #pre_paid_travel_expense
  #pre_disbursement_processor_status

  #general_ledger_pending_entries





  #action(:calculate_per_diem) { |b| b.frm.button(title: 'Calculate Per Diem').click }
  #
  #action(:calculate_total_mileage) { |b| b.frm.button(title: 'Calculate Total Mileage').click }
  #
  #action(:add_expense_line) { |b| b.frm.button(title: 'Add Expense Line').click }
  #
  #action(:add_pre_conference_registrant_line) { |b| b.frm.button(title: 'Add Pre-Conference Registrant Line').click }
  #
  #action(:cancel_attachment) { |b| b.frm.button(title: 'Cancel Attachment').click }



end