class PaymentInformationTab < FinancialProcessingPage


  action(:labelled_fields) { |s, b| b.frm.th(text: /#{s}/m).parent.tds(class: 'datacell') }
  action(:labelled_field) { |s, c=0, b| b.labelled_fields(s)[c] }
  action(:payee_search) { |b| b.labelled_field('Payee ID', 0).input(title: /Search/m).click }

  value(:payment_reason_code) { |b| b.labelled_field('Payment Reason Code', 0).text }
  value(:payee_id) { |b| b.labelled_field('Payee ID', 0).text }
  value(:type) { |b| b.labelled_field('Payee Type',0 ).text }
  value(:payee_name) { |b| b.labelled_field('Payee Name', 1).text }
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
  value(:payee_id_value) { |b| b.frm.table(summary: 'Payment Section')[1][1].text }
  value(:address_1_value) { |b| b.frm.table(summary: 'Payment Section')[3][1].text }
  value(:address_2_value) { |b| b.frm.table(summary: 'Payment Section')[3][3].text }
  value(:city_value) { |b| b.frm.table(summary: 'Payment Section')[4][1].text }
  value(:state_value) { |b| b.frm.table(summary: 'Payment Section')[4][3].text }
  value(:country_value) { |b| b.frm.table(summary: 'Payment Section')[5][1].text }
  value(:postal_code_value) { |b| b.frm.table(summary: 'Payment Section')[5][3].text }
end
