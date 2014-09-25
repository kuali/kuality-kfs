class PaymentRequestPage < KFSBasePage

  element(:vendor_address_1) { |b| b.frm.text_field(name: 'document.vendorLine1Address') }
  element(:pay_date) { |b| b.frm.text_field(name: 'document.paymentRequestPayDate') }

  element(:vendor_section) { |b| b.frm.table(class: 'datatable', summary: 'Vendor Section') }

  value(:result_vendor_address_1) { |b| b.vendor_section.rows[3].tds[0].text.strip }

  # Tax Tab
  element(:income_class_code) { |b| b.frm.select(id: 'document.taxClassificationCode') }
  element(:federal_tax_pct) { |b| b.frm.text_field(id: 'document.taxFederalPercent') }
  element(:state_tax_pct) { |b| b.frm.text_field(id: 'document.taxStatePercent') }
  element(:postal_country_code) { |b| b.frm.select(id: 'document.taxCountryCode') }

end