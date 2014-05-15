class CABPurchasingAccountsPayableReportLookupPage < Lookups

  element(:purchase_order) { |b| b.frm.text_field(name: 'referenceFinancialDocumentNumber') }
  element(:select_document_type) { |b| b.frm.select(name: 'financialDocumentTypeCode') }
  element(:preq_cm_id) { |b| b.frm.text_field(name: 'purapDocumentIdentifier') }

  element(:document_number) { |b| b.frm.text_field(name: 'documentNumber') }
  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:object_code) { |b| b.frm.text_field(name: 'financialObjectCode') }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:fiscal_period) { |b| b.frm.text_field(name: 'universityFiscalPeriodCode') }
  element(:transaction_post_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_transactionDate') }
  element(:transaction_post_date_to) { |b| b.frm.text_field(name: 'transactionDate') }

  element(:submit_to_cams_yes) { |b| b.frm.radio(id: 'activityStatusCodeYes') }
  element(:submit_to_cams_no) { |b| b.frm.radio(id: 'activityStatusCodeNo') }
  element(:submit_to_cams_both) { |b| b.frm.radio(id: 'activityStatusCodeBoth') }

end