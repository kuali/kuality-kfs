class VendorPage < KFSBasePage

  value(:vendor_number) { |b| b.frm.span(id: 'document.newMaintainableObject.vendorNumber.div').text.strip }
  alias_method :new_vendor_number, :vendor_number
  element(:vendor_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorName') }
  alias_method :new_vendor_name, :vendor_name
  element(:vendor_last_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorLastName') }
  alias_method :new_vendor_last_name, :vendor_last_name
  element(:vendor_first_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorFirstName') }
  alias_method :new_vendor_first_name, :vendor_first_name
  element(:vendor_type) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorTypeCode') }
  element(:new_vendor_type) { |b| b.frm.span(id: 'document.newMaintainableObject.vendorHeader.vendorTypeCode.div') }
  element(:foreign) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorForeignIndicator') }
  alias_method :new_foreign, :foreign
  element(:tax_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorHeader.vendorTaxNumber') }
  alias_method :new_tax_number, :tax_number

  value(:new_tax_number_type) { |b| b.frm.input(name: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCode').parent.tds[1].text.strip }
  element(:tax_number_type_fein) do |b|
    if b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeFEIN').exists?
      b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeFEIN')
    else
      if b.new_tax_number_type == 'FEIN'
        :set
      else
        :clear
      end
    end
  end
  alias_method :new_tax_number_type_fein, :tax_number_type_fein
  element(:tax_number_type_ssn) do |b|
    if b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeSSN').exists?
      b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeSSN')
    else
      if b.new_tax_number_type == 'SSN'
        :set
      else
        :clear
      end
    end
  end
  alias_method :new_tax_number_type_ssn, :tax_number_type_ssn
  element(:tax_number_type_none) do |b|
    b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeNONE')
    if b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeNONE').exists?
      b.frm.radio(id: 'document.newMaintainableObject.vendorHeader.vendorTaxTypeCodeNONE')
    else
      if b.new_tax_number_type == 'NONE'
        :set
      else
        :clear
      end
    end
  end
  alias_method :new_tax_number_type_none, :tax_number_type_none

  element(:ownership) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorOwnershipCode') }
  alias_method :new_ownership, :ownership
  element(:w9_received) { |b| b.frm.select(name: 'document.newMaintainableObject.vendorHeader.vendorW9ReceivedIndicator') }
  alias_method :new_w9_received, :w9_received
  element(:hidden_tax_number) { |b| b.frm.hidden(name: 'document.newMaintainableObject.vendorHeader.vendorTaxNumber') }
  alias_method :new_hidden_tax_number, :hidden_tax_number

  element(:old_vendor_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorNumber.div').text.strip }
  element(:old_vendor_name) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorName.div').text.strip }
  element(:old_vendor_last_name) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorLastName.div').text.strip }
  element(:old_vendor_first_name) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorFirstName.div').text.strip }
  element(:old_vendor_type) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorTypeCode.div').text.strip }
  element(:old_foreign) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorForeignIndicator.div').text.strip }
  element(:old_tax_number) do |b|
    otn = ''
    if b.hidden_tax_number.exists?
      otn = b.hidden_tax_number.parent.tds[0].text.strip
    else
      otn = b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorTaxNumber.div').text.strip
    end
    otn
  end
  element(:old_tax_number_type) { |b| b.frm.input(name: 'document.oldMaintainableObject.vendorHeader.vendorTaxTypeCode').parent.tds[0].text.strip }
  element(:old_tax_number_type_fein) { |b| (b.old_tax_number_type == 'FEIN') ? :set : :clear }
  element(:old_tax_number_type_ssn) { |b| (b.old_tax_number_type == 'SSN') ? :set : :clear }
  element(:old_tax_number_type_none) { |b| (b.old_tax_number_type == 'NONE') ? :set : :clear }
  element(:old_ownership) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorOwnershipCode.div').text.strip }
  element(:old_w9_received) { |b| b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorW9ReceivedIndicator.div').text.strip }

  # Contracts Tab
  element(:contracts_tab) { |b| b.frm.div(id: 'tab-Contracts-div') }
  value(:current_contracts_count) { |b| b.contracts_tab.spans(class: 'left', text: /Contract [(]/m).length }
  action(:add_contract) { |b| b.contracts_tab.button(id: /methodToCall.addLine.vendorContracts/m).click }
  action(:delete_contract) { |i=0, b| b.contracts_tab.button(id: "methodToCall.deleteLine.vendorContracts.(!!.line#{i}").click }
  action(:show_contracts_button) { |b| b.frm.button(id: 'tab-Contracts-imageToggle') }
  value(:contracts_tab_shown?) { |b| b.show_contracts_button.title.match(/close Contracts/m) }
  value(:contracts_tab_hidden?) { |b| !b.contracts_tab_shown? }
  action(:show_contracts) { |b| b.show_contracts_button.click }
  alias_method :hide_contracts, :show_contracts

  element(:contract_number) { |b| warn 'VendorPage#new_contract_number does not return a value! Please implement this method if you need it!'; '' }
  alias_method :new_contract_number, :contract_number
  element(:contract_name) { |b| b.contracts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractName') }
  alias_method :new_contract_name, :contract_name
  element(:contract_description) { |b| b.contracts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractDescription') }
  alias_method :new_contract_description, :contract_description
  element(:contract_campus_code) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorCampusCode') }
  alias_method :new_contract_campus_code, :contract_campus_code
  element(:contract_begin_date) { |b| b.contracts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractBeginningDate') }
  alias_method :new_contract_begin_date, :contract_begin_date
  element(:contract_end_date) { |b| b.contracts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractEndDate') }
  alias_method :new_contract_end_date, :contract_end_date
  element(:contract_manager) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.contractManagerCode') }
  alias_method :new_contract_manager, :contract_manager
  element(:contract_po_cost_source) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.purchaseOrderCostSourceCode') }
  alias_method :new_contract_po_cost_source, :contract_po_cost_source
  element(:b2b_contract_indicator) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorB2bIndicator') }
  alias_method :new_b2b_contract_indicator, :b2b_contract_indicator
  element(:contract_payment_terms) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorPaymentTermsCode') }
  alias_method :new_contract_payment_terms, :contract_payment_terms
  element(:contract_shipping_terms) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingPaymentTermsCode') }
  alias_method :new_contract_shipping_terms, :contract_shipping_terms
  element(:contract_shipping_title) { |b| b.contracts_tab.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingTitleCode') }
  alias_method :new_contract_shipping_title, :contract_shipping_title
  element(:contract_default_apo_limit) { |b| b.contracts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContracts.organizationAutomaticPurchaseOrderLimit') }
  alias_method :new_contract_default_apo_limit, :contract_default_apo_limit
  element(:contract_active_indicator) { |b| b.contracts_tab.checkbox(name: 'document.newMaintainableObject.add.vendorContracts.active') }
  alias_method :new_contract_active_indicator, :contract_active_indicator

  value(:update_contract_number) { |i=0, b| b.contracts_tab.span(id: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractGeneratedIdentifier.div").text.strip }
  action(:update_contract_name) { |i=0, b| b.contracts_tab.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractName") }
  action(:update_contract_description) { |i=0, b| b.contracts_tab.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractDescription") }
  action(:update_contract_campus_code) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorCampusCode") }
  action(:update_contract_begin_date) { |i=0, b| b.contracts_tab.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractBeginningDate") }
  action(:update_contract_end_date) { |i=0, b| b.contracts_tab.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractEndDate") }
  action(:update_contract_manager) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].contractManagerCode") }
  action(:update_contract_po_cost_source) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].purchaseOrderCostSourceCode") }
  action(:update_b2b_contract_indicator) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorB2bIndicator") }
  action(:update_contract_payment_terms) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorPaymentTermsCode") }
  action(:update_contract_shipping_terms) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorShippingPaymentTermsCode") }
  action(:update_contract_shipping_title) { |i=0, b| b.contracts_tab.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorShippingTitleCode") }
  action(:update_contract_default_apo_limit) { |i=0, b| b.contracts_tab.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].organizationAutomaticPurchaseOrderLimit") }
  action(:update_contract_active_indicator) { |i=0, b| b.contracts_tab.checkbox(name: "document.newMaintainableObject.vendorContracts[#{i}].active") }

  value(:old_contract_number) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorContractGeneratedIdentifier.div").text.strip }
  action(:old_contract_name) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorContractName.div").text.strip }
  action(:old_contract_description) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorContractDescription.div").text.strip }
  action(:old_contract_campus_code) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorCampusCode.div").text.strip }
  action(:old_contract_begin_date) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorContractBeginningDate.div").text.strip }
  action(:old_contract_end_date) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorContractEndDate.div").text.strip }
  action(:old_contract_manager) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].contractManagerCode.div").text.strip }
  action(:old_contract_po_cost_source) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].purchaseOrderCostSourceCode.div").text.strip }
  action(:old_b2b_contract_indicator) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorB2bIndicator.div").text.strip }
  action(:old_contract_payment_terms) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorPaymentTermsCode.div").text.strip }
  action(:old_contract_shipping_terms) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorShippingPaymentTermsCode.div").text.strip }
  action(:old_contract_shipping_title) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].vendorShippingTitleCode.div").text.strip }
  action(:old_contract_default_apo_limit) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].organizationAutomaticPurchaseOrderLimit.div").text.strip }
  action(:old_contract_active_indicator) { |i=0, b| b.contracts_tab.span(id: "document.oldMaintainableObject.vendorContracts[#{i}].active.div").text.strip }

  # Phone Tab
  element(:phone_numbers_tab) { |b| b.frm.div(id: 'tab-VendorPhoneNumber-div') }
  value(:current_phone_number_count) { |b| b.phone_numbers_tab.spans(class: 'left', text: /Phone Numbers [(]/m).length }
  action(:add_phone_number) { |b| b.frm.button(id: /methodToCall.addLine.vendorPhoneNumbers/m).click }
  action(:delete_phone_number) { |i=0, b| b.frm.button(id: "methodToCall.deleteLine.vendorPhoneNumbers.(!!.line#{i}").click }
  action(:show_phone_numbers_button) { |b| b.frm.button(id: 'tab-CustomerNumber-imageToggle') }
  value(:phone_numbers_tab_shown?) { |b| b.show_phone_numbers_button.title.match(/close Customer Number/m) }
  value(:phone_numbers_tab_hidden?) { |b| !b.phone_numbers_tab_shown? }
  action(:show_phone_numbers) { |b| b.show_phone_numbers_button.click }
  alias_method :hide_phone_numbers, :show_phone_numbers

  element(:phone_type) { |b| b.phone_numbers_tab.select(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneTypeCode') }
  alias_method :new_phone_type, :phone_type
  element(:phone_number) { |b| b.phone_numbers_tab.text_field(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneNumber') }
  alias_method :new_phone_number, :phone_number
  element(:phone_extension) { |b| b.phone_numbers_tab.text_field(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneExtensionNumber') }
  alias_method :new_phone_extension, :phone_extension
  element(:phone_active_indicator) { |b| b.phone_numbers_tab.checkbox(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.active') }
  alias_method :new_phone_active_indicator, :phone_active_indicator

  action(:update_phone_type) { |i=0, b| b.phone_numbers_tab.select(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneTypeCode") }
  alias_method :updated_phone_type, :update_phone_type
  action(:update_phone_number) { |i=0, b| b.phone_numbers_tab.text_field(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneNumber") }
  alias_method :updated_phone_number, :update_phone_number
  action(:update_phone_extension) { |i=0, b| b.phone_numbers_tab.text_field(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneExtensionNumber") }
  alias_method :updated_phone_ext, :update_phone_extension
  action(:update_phone_active_indicator) { |i=0, b| b.phone_numbers_tab.checkbox(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].active") }

  action(:old_phone_type) { |i=0, b| b.phone_numbers_tab.span(id: "document.oldMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneTypeCode.div").text.strip }
  action(:old_phone_number) { |i=0, b| b.phone_numbers_tab.span(id: "document.oldMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneNumber.div").text.strip }
  action(:old_phone_extension) { |i=0, b| b.phone_numbers_tab.span(id: "document.oldMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneExtensionNumber.div").text.strip }
  action(:old_phone_active_indicator) { |i=0, b| b.phone_numbers_tab.span(id: "document.oldMaintainableObject.vendorPhoneNumbers[#{i}].active.div").text.strip }

  # Address Tab
  element(:addresses_tab) { |b| b.frm.div(id: 'tab-Address-div') }
  value(:current_address_count) { |b| b.addresses_tab.inputs(alt: /(close|open) Address [(]/m).length }
  action(:add_address) { |b| b.addresses_tab.button(id: /methodToCall.addLine.vendorAddresses/m).click }
  action(:show_addresses_button) { |b| b.frm.button(id: 'tab-Address-imageToggle') }
  value(:addresses_tab_shown?) { |b| b.show_addresses_button.title.match(/close Address/m) }
  value(:addresses_tab_hidden?) { |b| !b.addresses_tab_shown? }
  action(:show_addresses) { |b| b.show_addresses_button.click }
  alias_method :hide_addresses, :show_addresses

  element(:address_type) { |b| b.addresses_tab.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressTypeCode') }
  alias_method :new_address_type, :address_type
  element(:address_1) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine1Address') }
  alias_method :new_address_1, :address_1
  element(:address_2) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine2Address') }
  alias_method :new_address_2, :address_2
  element(:city) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCityName') }
  alias_method :new_city, :city
  element(:state) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorStateCode') }
  alias_method :new_state, :state
  element(:zipcode) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorZipCode') }
  alias_method :new_zipcode, :zipcode
  element(:province) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressInternationalProvinceName') }
  alias_method :new_province, :province
  element(:country) { |b| b.addresses_tab.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCountryCode') }
  alias_method :new_country, :country
  element(:address_attention) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAttentionName') }
  alias_method :new_address_attention, :address_attention
  element(:address_url) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorBusinessToBusinessUrlAddress') }
  alias_method :new_address_url, :address_url
  element(:fax) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorFaxNumber') }
  alias_method :new_fax, :fax
  element(:email) { |b| b.addresses_tab.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressEmailAddress') }
  alias_method :new_email, :email
  element(:default_address) { |b| b.addresses_tab.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorDefaultAddressIndicator') }
  alias_method :new_default_address, :default_address
  element(:address_active_indicator) { |b| b.addresses_tab.checkbox(name: 'document.newMaintainableObject.add.vendorAddresses.active') }
  alias_method :new_address_active_indicator, :address_active_indicator

  action(:update_address_type) { |i=0, b| b.addresses_tab.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressTypeCode") }
  alias_method :address_type_1, :update_address_type
  action(:update_address_1) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorLine1Address") }
  alias_method :updated_address_1, :update_address_1
  action(:update_address_2) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorLine2Address") }
  alias_method :updated_address_2, :update_address_2
  value(:updated_2nd_address_2) { |b| b.update_address_2(1) }
  action(:update_city) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorCityName") }
  action(:update_state) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorStateCode") }
  action(:update_zipcode) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorZipCode") }
  action(:update_province) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressInternationalProvinceName") }
  action(:update_country) { |i=0, b| b.addresses_tab.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorCountryCode") }
  action(:update_address_attention) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAttentionName") }
  alias_method :updated_address_attention, :update_address_attention
  action(:update_address_url) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorBusinessToBusinessUrlAddress") }
  action(:update_fax) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorFaxNumber") }
  action(:update_email) { |i=0, b| b.addresses_tab.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressEmailAddress") }
  action(:update_default_address) { |i=0, b| b.addresses_tab.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorDefaultAddressIndicator") }
  action(:update_address_active_indicator) { |i=0, b| b.addresses_tab.checkbox(name: "document.newMaintainableObject.vendorAddresses[#{i}].active") }

  action(:old_address_type) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorAddressTypeCode.div").text.strip }
  action(:old_address_1) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorLine1Address.div").text.strip }
  action(:old_address_2) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorLine2Address.div").text.strip }
  action(:old_city) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorCityName.div").text.strip }
  action(:old_state) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorStateCode.div").text.strip }
  action(:old_zipcode) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorZipCode.div").text.strip }
  action(:old_province) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorAddressInternationalProvinceName.div").text.strip }
  action(:old_country) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorCountryCode.div").text.strip }
  action(:old_address_attention) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorAttentionName.div").text.strip }
  action(:old_address_url) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorBusinessToBusinessUrlAddress.div").text.strip }
  action(:old_fax) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorFaxNumber.div").text.strip }
  action(:old_email) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorAddressEmailAddress.div").text.strip }
  action(:old_default_address) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].vendorDefaultAddressIndicator.div").text.strip }
  action(:old_address_active_indicator) { |i=0, b| b.addresses_tab.span(id: "document.oldMaintainableObject.vendorAddresses[#{i}].active.div").text.strip }

  # Contact Tab
  element(:contacts_tab) { |b| b.frm.div(id: 'tab-Contact-div') }
  value(:current_contacts_count) { |b| b.contacts_tab.spans(class: 'left', text: /Contact [(]/m).length }
  action(:add_contact) { |b| b.contacts_tab.button(id: /methodToCall.addLine.vendorContacts/m).click }
  action(:show_contacts_button) { |b| b.frm.button(id: 'tab-Contact-imageToggle') }
  value(:contacts_tab_shown?) { |b| b.show_contacts_button.title.match(/close Customer Number/m) }
  value(:contacts_tab_hidden?) { |b| !b.contacts_tab_shown? }
  action(:show_contacts) { |b| b.show_contacts_button.click }
  alias_method :hide_contacts, :show_contacts

  element(:contact_type) { |b| b.contacts_tab.select(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactTypeCode') }
  alias_method :new_contact_type, :contact_type
  element(:contact_name) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactName') }
  alias_method :new_contact_name, :contact_name
  element(:contact_email) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactEmailAddress') }
  alias_method :new_contact_email, :contact_email
  element(:contact_address_1) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorLine1Address') }
  alias_method :new_contact_address_1, :contact_address_1
  element(:contact_address_2) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorLine2Address') }
  alias_method :new_contact_address_2, :contact_address_2
  element(:contact_city) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorCityName') }
  alias_method :new_contact_city, :contact_city
  element(:contact_state) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorStateCode') }
  alias_method :new_contact_state, :contact_state
  element(:contact_zipcode) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorZipCode') }
  alias_method :new_contact_zipcode, :contact_zipcode
  element(:contact_province) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorAddressInternationalProvinceName') }
  alias_method :new_contact_province, :contact_province
  element(:contact_country) { |b| b.contacts_tab.select(name: 'document.newMaintainableObject.add.vendorContacts.vendorCountryCode') }
  alias_method :new_contact_country, :contact_country
  element(:contact_attention) { |b| b.contacts_tab.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorAttentionName') }
  alias_method :new_contact_attention, :contact_attention
  element(:contact_comments) { |b| b.contacts_tab.textarea(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactCommentText') }
  alias_method :new_contact_comments, :contact_comments
  element(:contact_active_indicator) { |b| b.contacts_tab.checkbox(name: 'document.newMaintainableObject.add.vendorContacts.active') }
  alias_method :new_contact_active_indicator, :contact_active_indicator

  action(:update_contact_type) { |i=0, b| b.contacts_tab.select(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactTypeCode") }
  action(:update_contact_name) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactName") }
  action(:update_contact_email) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactEmailAddress") }
  action(:update_contact_address_1) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorLine1Address") }
  action(:update_contact_address_2) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorLine2Address") }
  action(:update_contact_city) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorCityName") }
  action(:update_contact_state) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorStateCode") }
  action(:update_contact_zipcode) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorZipCode") }
  action(:update_contact_province) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorAddressInternationalProvinceName") }
  action(:update_contact_country) { |i=0, b| b.contacts_tab.select(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorCountryCode") }
  action(:update_contact_attention) { |i=0, b| b.contacts_tab.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorAttentionName") }
  action(:update_contact_comments) { |i=0, b| b.contacts_tab.textarea(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactCommentText") }
  action(:update_contact_active_indicator) { |i=0, b| b.contacts_tab.checkbox(name: "document.newMaintainableObject.vendorContacts[#{i}].active") }

  action(:old_contact_type) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorContactTypeCode.div").text.strip }
  action(:old_contact_name) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorContactName.div").text.strip }
  action(:old_contact_email) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorContactEmailAddress.div").text.strip }
  action(:old_contact_address_1) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorLine1Address.div").text.strip }
  action(:old_contact_address_2) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorLine2Address.div").text.strip }
  action(:old_contact_city) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorCityName.div").text.strip }
  action(:old_contact_state) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorStateCode.div").text.strip }
  action(:old_contact_zipcode) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorZipCode.div").text.strip }
  action(:old_contact_province) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorAddressInternationalProvinceName.div").text.strip }
  action(:old_contact_country) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorCountryCode.div").text.strip }
  action(:old_contact_attention) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorAttentionName.div").text.strip }
  action(:old_contact_comments) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].vendorContactCommentText.div").text.strip }
  action(:old_contact_active_indicator) { |i=0, b| b.contacts_tab.span(id: "document.oldMaintainableObject.vendorContacts[#{i}].active.div").text.strip }

  # Search Alias
  element(:search_alias_tab) { |b| b.frm.div(id: 'tab-SearchAlias-div') }
  value(:current_search_alias_count) { |b| b.search_alias_tab.spans(class: 'left', text: /Search Alias [(]/m).length }
  action(:add_search_alias) { |b| b.frm.button(id: 'methodToCall.addLine.vendorAliases.(!!org.kuali.kfs.vnd.businessobject.VendorAlias!!)').click }
  action(:delete_search_alias) { |i=0, b| b.search_alias_tab.button(id: "methodToCall.deleteLine.vendorAliases.(!!.line#{i}").click }

  action(:show_search_aliases_button) { |b| b.frm.button(id: 'tab-SearchAlias-imageToggle') }
  value(:search_aliases_tab_shown?) { |b| b.show_search_aliases_button.title.match(/close Search Alias/m) }
  value(:search_aliases_tab_hidden?) { |b| !b.search_aliases_tab_shown? }
  action(:show_search_aliases) { |b| b.show_search_aliases_button.click }
  alias_method :hide_contacts, :show_search_aliases

  element(:search_alias_active) { |b| b.frm.checkbox(id: 'document.newMaintainableObject.add.vendorAliases.active') }
  alias_method :new_search_alias_active, :search_alias_active
  element(:search_alias_name) { |b| b.frm.text_field(id: 'document.newMaintainableObject.add.vendorAliases.vendorAliasName') }
  alias_method :new_search_alias_name, :search_alias_name

  action(:update_search_alias_active) { |i=0, b| b.search_alias_tab.checkbox(id: "document.newMaintainableObject.vendorAliases[#{i}].active").value }
  action(:update_search_alias_name) { |i=0, b| b.search_alias_tab.span(id: "document.newMaintainableObject.vendorAliases[#{i}].vendorAliasName.div").text.strip }

  action(:old_search_alias_active) { |i=0, b| b.search_alias_tab.span(id: "document.oldMaintainableObject.vendorAliases[#{i}].active.div").text.strip }
  action(:old_search_alias_name) { |i=0, b| b.search_alias_tab.span(id: "document.oldMaintainableObject.vendorAliases[#{i}].vendorAliasName.div").text.strip }

end
