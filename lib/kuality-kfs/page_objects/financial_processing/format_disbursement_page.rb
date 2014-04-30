class FormatDisbursementPage < KFSBasePage

  element(:payment_date) { |b| b.frm.text_field(id: 'paymentDate') }
  element(:customer_boxes) { |b| b.frm.checkboxes(id: /selectedForFormat$/m) }
  element(:all_payment_type) { |b| b.frm.radio(name: 'paymentTypes', value: 'all') }
  element(:all_payment_distribution) { |b| b.frm.radio(name: 'paymentDistribution', value: 'all') }
  action(:begin_format) { |b| b.frm.button(name: 'methodToCall.prepare').click }
end
