class SpecialHandlingTab < FinancialProcessingPage

  element(:address_1) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingLine1Addr') }
  element(:address_2) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingLine2Addr') }
  element(:person_name) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingPersonName') }
  element(:city) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingCityName') }
  element(:state) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingStateCode') }
  element(:country) { |b| b.frm.select(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingCountryCode') }
  element(:postal_code) { |b| b.frm.text_field(id: 'document.dvPayeeDetail.disbVchrSpecialHandlingZipCode') }
  element(:close_special_handling) { |b| b.frm.button(title: 'close Special Handling') }
end
