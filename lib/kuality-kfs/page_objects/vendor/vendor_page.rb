class VendorPage < KFSBasePage

  notes_and_attachments

  element(:vendor_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorName') }
  element(:vendor_last_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorLastName') }
  element(:vendor_first_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorFirstName') }
  element(:vendor_type) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorTypeCode') }
  element(:foreign) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorForeignIndicator') }
  element(:tax_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorHeader.vendorTaxNumber') }
  element(:tax_number_type_fein) {|b| b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeFEIN') }
  element(:tax_number_type_ssn) {|b| b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeSSN') }
  element(:tax_number_type_none) {|b| b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeNONE') }
  element(:ownership) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorOwnershipCode') }
  element(:w9_received) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorW9ReceivedIndicator') }
  element(:address_type) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressTypeCode') }
  element(:address_1) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine1Address') }
  element(:address_2) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine2Address') }
  element(:city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCityName') }
  element(:state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorStateCode') }
  element(:zipcode) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorZipCode') }
  element(:country) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCountryCode') }
  element(:default_address) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorDefaultAddressIndicator') }
  action(:add_address) { |b| b.frm.button(id: /methodToCall.addLine.vendorAddresses/m).click }
  element(:supplier_diversity) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorHeader.vendorSupplierDiversities.vendorSupplierDiversityCode') }
  action(:add_supplier_diversity) { |b| b.frm.button(id: /methodToCall.addLine.vendorHeader.vendorSupplierDiversities/m).click }
  element(:contract_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractName') }
  element(:contract_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractDescription') }
  element(:contract_begin_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractBeginningDate') }
  element(:contract_end_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractEndDate') }
  element(:contract_po_limit) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.organizationAutomaticPurchaseOrderLimit') }
  element(:contract_manager_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.contractManagerCode') }
  element(:po_cost_source_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.purchaseOrderCostSourceCode') }
  element(:b2b_contract_indicator) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorB2bIndicator') }
  element(:vendor_pmt_terms_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorPaymentTermsCode') }
  element(:vendor_shipping_pmt_terms_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingPaymentTermsCode') }
  element(:vendor_shipping_title_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingTitleCode') }
  element(:vendor_b2b_indicator) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorB2bIndicator') }
  element(:contract_campus_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorCampusCode') }
  action(:add_vendor_contract) { |b| b.frm.button(id: /methodToCall.addLine.vendorContracts/m).click }

end
