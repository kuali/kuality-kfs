class PaymentInformationTab < FinancialProcessingPage

  value(:payment_reason_code) { |b| b.frm.th(text: 'Payee ID:').parent.td(class: 'datacell').text }
  value(:payee_id) { |b| b.frm.th(text: 'Payee ID:').parent.td(class: 'datacell').text }
  value(:type) { |b| b.frm.th(text: 'Payee Type:').parent.td(class: 'datacell').text }
  value(:payee_name) { |b| b.frm.th(text: 'Payee Name:').parent.td(class: 'datacell').text }
  element(:address_1) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrPayeeLine1Addr') }
  element(:address_2) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrPayeeLine2Addr') }
  element(:city) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrPayeeCityName') }
  element(:state) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrPayeeStateCode') }
  element(:country) { |b| b.frm.select(id: 'document.dvPayeeDetail.disbVchrPayeeCountryCode') }
  element(:postal_code) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrPayeeZipCode') }
  element(:due_date) { |b| b.frm.text_field(id: 'document.disbursementVoucherDueDate') }
  element(:other_considerations_check_enclosure) { |b| b.frm.checkbox(id: 'document.disbVchrAttachmentCode') }
  element(:other_considerations_special_handling) { |b| b.frm.checkbox(id: 'document.disbVchrSpecialHandlingCode') }
  element(:other_considerations_w9_completed) { |b| b.frm.checkbox(id: 'document.disbVchrPayeeW9CompleteCode') }
  element(:other_considerations_exception_attached) { |b| b.frm.checkbox(id: 'document.disbExcptAttachedIndicator') }
  element(:other_considerations_immediate_payment_indicator) { |b| b.frm.checkbox(id: 'document.immediatePaymentIndicator') }

  element(:check_amount) { |b| b.frm.text_field(id: 'document.disbVchrCheckTotalAmount') }
  element(:payment_method) { |b| b.frm.select(id: 'document.disbVchrPaymentMethodCode') }
  element(:check_stub_text) { |b| b.frm.text_field(id: 'document.disbVchrCheckStubText') }
  element(:documentation_location_code) { |b| b.frm.select(id: 'document.disbursementVoucherDocumentationLocationCode') }

end
