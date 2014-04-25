class NonresidentAlienTaxTab < FinancialProcessingPage

  element(:income_class_code) { |b| b.frm.select(id: 'document.dvNonResidentAlienTax.incomeClassCode') }
  element(:federal_income_tax_pct) { |b| b.frm.text_field(id: 'document.dvNonResidentAlienTax.federalIncomeTaxPercent') }
  element(:state_income_tax_pct) { |b| b.frm.text_field(id: 'document.dvNonResidentAlienTax.stateIncomeTaxPercent') }
  element(:postal_country_code) { |b| b.frm.select(id: 'document.dvNonResidentAlienTax.postalCountryCode') }
  action(:generate_line) { |b| b.frm.button(name: /methodToCall.generateNonResidentAlienTaxLines/m).click }

end