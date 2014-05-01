class VendorPage < KFSBasePage

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

  # Contracts Tab
  action(:add_contract) { |b| b.frm.button(id: /methodToCall.addLine.vendorContracts/m).click }
  action(:delete_contract) { |i=0, b| b.frm.button(id: "methodToCall.deleteLine.vendorContracts.(!!.line#{i}").click }
  action(:show_contracts) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabContracts').click }

  element(:new_contract_number) { |b| warn 'VendorPage#new_contract_number does not return a value! Please implement this method if you need it!'; '' }
  alias_method :contract_number, :new_contract_number
  element(:new_contract_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractName') }
  alias_method :contract_name, :new_contract_name
  element(:new_contract_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractDescription') }
  alias_method :contract_description, :new_contract_description
  element(:new_contract_campus_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorCampusCode') }
  alias_method :contract_campus_code, :new_contract_campus_code
  element(:new_contract_begin_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractBeginningDate') }
  alias_method :contract_begin_date, :new_contract_begin_date
  element(:new_contract_end_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractEndDate') }
  alias_method :contract_end_date, :new_contract_end_date
  element(:new_contract_manager) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.contractManagerCode') }
  alias_method :contract_manager, :new_contract_manager
  element(:new_contract_po_cost_source) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.purchaseOrderCostSourceCode') }
  alias_method :contract_po_cost_source, :new_contract_po_cost_source
  element(:new_b2b_contract_indicator) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorB2bIndicator') }
  alias_method :b2b_contract_indicator, :new_b2b_contract_indicator
  element(:new_contract_payment_terms) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorPaymentTermsCode') }
  alias_method :contract_payment_terms, :new_contract_payment_terms
  element(:new_contract_shipping_terms) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingPaymentTermsCode') }
  alias_method :contract_shipping_terms, :new_contract_shipping_terms
  element(:new_contract_shipping_title) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContracts.vendorShippingTitleCode') }
  alias_method :contract_shipping_title, :new_contract_shipping_title
  element(:new_contract_extension_option_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.vendorContractExtensionDate') }
  alias_method :contract_extension_option_date, :new_contract_extension_option_date
  element(:new_contract_default_apo_limit) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContracts.organizationAutomaticPurchaseOrderLimit') }
  alias_method :contract_default_apo_limit, :new_contract_default_apo_limit
  element(:new_contract_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.vendorContracts.active') }
  alias_method :contract_active_indicator, :new_contract_active_indicator

  value(:update_contract_number) { |i=0, b| b.frm.span(id: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractGeneratedIdentifier.div").text.strip }
  action(:update_contract_name) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractName") }
  action(:update_contract_description) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractDescription") }
  action(:update_contract_campus_code) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorCampusCode") }
  action(:update_contract_begin_date) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractBeginningDate") }
  action(:update_contract_end_date) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractEndDate") }
  action(:update_contract_manager) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].contractManagerCode") }
  action(:update_contract_po_cost_source) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].purchaseOrderCostSourceCode") }
  action(:update_b2b_contract_indicator) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorB2bIndicator") }
  action(:update_contract_payment_terms) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorPaymentTermsCode") }
  action(:update_contract_shipping_terms) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorShippingPaymentTermsCode") }
  action(:update_contract_shipping_title) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorShippingTitleCode") }
  action(:update_contract_extension_option_date) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].vendorContractExtensionDate") }
  action(:update_contract_default_apo_limit) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContracts[#{i}].organizationAutomaticPurchaseOrderLimit") }
  action(:update_contract_active_indicator) { |i=0, b| b.frm.checkbox(name: "document.newMaintainableObject.vendorContracts[#{i}].active") }

  action(:pull_existing_contract) do |i=0, b|
    {
        number:                b.update_contract_number(i),
        name:                  b.update_contract_name(i).value.strip,
        description:           b.update_contract_description(i).value.strip,
        campus_code:           b.update_contract_campus_code(i).selected_options.first.value,
        begin_date:            b.update_contract_begin_date(i).value.strip,
        end_date:              b.update_contract_end_date(i).value.strip,
        manager:               b.update_contract_manager(i).selected_options.first.text,
        po_cost_source:        b.update_contract_po_cost_source(i).selected_options.first.text,
        b2b:                   b.update_b2b_contract_indicator(i).selected_options.first.text,
        payment_terms:         b.update_contract_payment_terms(i).selected_options.first.text,
        shipping_terms:        b.update_contract_shipping_terms(i).selected_options.first.text,
        shipping_title:        b.update_contract_shipping_title(i).selected_options.first.text,
        extension_option_date: b.update_contract_extension_option_date(i).value.strip,
        default_apo_limit:     b.update_contract_default_apo_limit(i).value.strip,
        active:                yesno2setclear(b.update_contract_active_indicator(i).value)
    }
  end
  value(:current_contracts_count) { |b| b.frm.div(id: 'tab-Contracts-div').spans(class: 'left', text: /Contract [(]/m).length }

  # Phone Tab
  action(:show_phone_numbers) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabVendorPhoneNumber').click }
  element(:phone_type) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneTypeCode') }
  element(:phone_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneNumber') }
  element(:phone_extension) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.vendorPhoneExtensionNumber') }
  element(:phone_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.vendorPhoneNumbers.active') }
  action(:add_phone_number) { |b| b.frm.button(id: /methodToCall.addLine.vendorPhoneNumbers/m).click }
  action(:update_phone_type) { |i=0, b| b.frm.select(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneTypeCode") }
  alias_method :updated_phone_type, :update_phone_type
  action(:update_phone_number) { |i=0, b| b.frm.text_field(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneNumber") }
  alias_method :updated_phone_number, :update_phone_number
  action(:update_phone_extension) { |i=0, b| b.frm.text_field(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].vendorPhoneExtensionNumber") }
  alias_method :updated_phone_ext, :update_phone_extension
  action(:update_phone_active_indicator) { |i=0, b| b.frm.checkbox(id: "document.newMaintainableObject.vendorPhoneNumbers[#{i}].active") }
  action(:delete_phone_number) { |i=0, b| b.frm.button(id: "methodToCall.deleteLine.vendorPhoneNumbers.(!!.line#{i}").click }
  action(:pull_existing_phone) do |i=0, b|
    {
      type:      b.update_phone_type(i).selected_options.first.text,
      number:    b.update_phone_number(i).value.strip,
      extension: b.update_phone_extension(i).value.strip,
      active:    yesno2setclear(b.update_phone_active_indicator(i).value)
    }
  end
  value(:current_phone_number_count) { |b| b.frm.div(id: 'tab-VendorPhoneNumber-div').spans(class: 'left', text: /Phone Numbers [(]/m).length }

  # Address Tab
  action(:add_address) { |b| b.frm.button(id: /methodToCall.addLine.vendorAddresses/m).click }
  action(:show_addresses) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabAddress').click }

  element(:address_type) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressTypeCode') }
  element(:address_1) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine1Address') }
  element(:address_2) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorLine2Address') }

  element(:city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCityName') }
  element(:state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorStateCode') }
  element(:zipcode) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorZipCode') }
  element(:province) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressInternationalProvinceName') }
  element(:country) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorCountryCode') }
  element(:address_attention) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAttentionName') }
  element(:address_url) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorBusinessToBusinessUrlAddress') }
  element(:fax) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorFaxNumber') }
  element(:email) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorAddresses.vendorAddressEmailAddress') }
  element(:default_address) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorAddresses.vendorDefaultAddressIndicator') }
  element(:address_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.vendorAddresses.active') }

  action(:update_address_type) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressTypeCode") }
  alias_method :address_type_1, :update_address_type

  action(:update_address_1) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorLine1Address") }
  alias_method :updated_address_1, :update_address_1
  action(:update_address_2) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorLine2Address") }
  alias_method :updated_address_2, :update_address_2
  value(:updated_2nd_address_2) { |b| b.update_address_2(1) }

  action(:update_city) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorCityName") }
  action(:update_state) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorStateCode") }
  action(:update_zipcode) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorZipCode") }
  action(:update_province) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressInternationalProvinceName") }
  action(:update_country) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorCountryCode") }
  action(:update_address_attention) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAttentionName") }
  alias_method :updated_address_attention, :update_address_attention
  action(:update_address_url) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorBusinessToBusinessUrlAddress") }
  action(:update_fax) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorFaxNumber") }
  action(:update_email) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorAddressEmailAddress") }
  action(:update_default_address) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorAddresses[#{i}].vendorDefaultAddressIndicator") }
  action(:update_address_active_indicator) { |i=0, b| b.frm.checkbox(name: "document.newMaintainableObject.vendorAddresses[#{i}].active") }

  action(:pull_existing_address) do |i, b|
    {
      type:           b.update_address_type(i).selected_options.first.text.strip,
      address_1:      b.update_address_1(i).value.strip,
      address_2:      b.update_address_2(i).value.strip,
      city:           b.update_city(i).value.strip,
      state:          b.update_state(i).value.strip,
      postal_code:    b.update_zipcode(i).value.strip,
      province:       b.update_province(i).value.strip,
      country:        b.update_country(i).selected_options.first.text.strip,
      attention:      b.update_address_attention(i).value.strip,
      url:            b.update_address_url(i).value.strip,
      fax:            b.update_fax(i).value.strip,
      email:          b.update_email(i).value.strip,
      set_as_default: b.update_default_address(i).selected_options.first.text,
      active:         yesno2setclear(b.update_address_active_indicator(i).value.strip)
    }
  end
  value(:current_address_count) { |b| b.frm.div(id: 'tab-Address-div').inputs(alt: /(close|open) Address [(]/m).length }

  # Contact Tab
  action(:add_contact) { |b| b.frm.button(id: /methodToCall.addLine.vendorContacts/m).click }
  action(:show_contacts) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabContact').click }

  element(:new_contact_type) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactTypeCode') }
  element(:new_contact_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactName') }
  element(:new_contact_email) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactEmailAddress') }
  element(:new_contact_address_1) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorLine1Address') }
  element(:new_contact_address_2) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorLine2Address') }
  element(:new_contact_city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorCityName') }
  element(:new_contact_state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorStateCode') }
  element(:new_contact_zipcode) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorZipCode') }
  element(:new_contact_province) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorAddressInternationalProvinceName') }
  element(:new_contact_country) { |b| b.frm.select(name: 'document.newMaintainableObject.add.vendorContacts.vendorCountryCode') }
  element(:new_contact_attention) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.vendorContacts.vendorAttentionName') }
  element(:new_contact_comments) { |b| b.frm.textarea(name: 'document.newMaintainableObject.add.vendorContacts.vendorContactCommentText') }
  element(:new_contact_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.vendorContacts.active') }

  action(:update_contact_type) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactTypeCode") }
  action(:update_contact_name) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactName") }
  action(:update_contact_email) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactEmailAddress") }
  action(:update_contact_address_1) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorLine1Address") }
  action(:update_contact_address_2) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorLine2Address") }
  action(:update_contact_city) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorCityName") }
  action(:update_contact_state) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorStateCode") }
  action(:update_contact_zipcode) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorZipCode") }
  action(:update_contact_province) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorAddressInternationalProvinceName") }
  action(:update_contact_country) { |i=0, b| b.frm.select(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorCountryCode") }
  action(:update_contact_attention) { |i=0, b| b.frm.text_field(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorAttentionName") }
  action(:update_contact_comments) { |i=0, b| b.frm.textarea(name: "document.newMaintainableObject.vendorContacts[#{i}].vendorContactCommentText") }
  action(:update_contact_active_indicator) { |i=0, b| b.frm.checkbox(name: "document.newMaintainableObject.vendorContacts[#{i}].active") }

  action(:pull_existing_contact) do |i, b|
    {
        type:           b.update_contact_type(i).selected_options.first.text.strip,
        name:           b.update_contact_name(i).value.strip,
        email:          b.update_contact_email(i).value.strip,
        address_1:      b.update_contact_address_1(i).value.strip,
        address_2:      b.update_contact_address_2(i).value.strip,
        city:           b.update_contact_city(i).value.strip,
        state:          b.update_contact_state(i).value.strip,
        postal_code:    b.update_contact_zipcode(i).value.strip,
        province:       b.update_contact_province(i).value.strip,
        country:        b.update_contact_country(i).selected_options.first.text,
        attention:      b.update_contact_attention(i).value.strip,
        comments:       b.update_contact_comments(i).value.strip,
        active:         yesno2setclear(b.update_contact_active_indicator(i).value.strip)
    }
  end
  value(:current_contacts_count) { |b| b.frm.div(id: 'tab-Contact-div').spans(class: 'left', text: /Contact [(]/m).length }

  element(:hidden_tax_number) { |b| b.frm.hidden(name: 'document.newMaintainableObject.vendorHeader.vendorTaxNumber') }

  value(:original_vendor_data) do |b|
    tax_number_type = b.frm.input(name: 'document.oldMaintainableObject.vendorHeader.vendorTaxTypeCode').parent.tds(class: 'grid')[0].text.strip
    {
      vendor_name:       b.frm.span(id: 'document.oldMaintainableObject.vendorName.div').text.strip,
      vendor_last_name:  b.frm.span(id: 'document.oldMaintainableObject.vendorLastName.div').text.strip,
      vendor_first_name: b.frm.span(id: 'document.oldMaintainableObject.vendorFirstName.div').text.strip,
      vendor_type: b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorTypeCode.div').text.strip,
      foreign:     b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorForeignIndicator.div').text.strip,
      tax_number:  b.frm.span(name: 'document.oldMaintainableObject.vendorHeader.vendorTaxNumber').text.strip,
      tax_number_type_fein: tax_number_type == 'FEIN' ? :set : :clear,
      tax_number_type_ssn:  tax_number_type == 'SSN' ? :set : :clear,
      tax_number_type_none: tax_number_type != 'FEIN' && tax_number_type != 'SSN' ? :set : :clear,
      ownership:   b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorOwnershipCode.div').text.strip,
      w9_received: b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.vendorW9ReceivedIndicator.div').text.strip,
      w9_received_date: b.frm.span(id: 'document.oldMaintainableObject.vendorHeader.extension.vendorW9ReceivedDate.div').text.strip,
      # TODO: Create an ContractLineObject >_<*
      # contract_name:        b.frm.span(id: '').text.strip,
      # contract_description: b.frm.span(id: '').text.strip,
      # contract_begin_date:  b.frm.span(id: '').text.strip,
      # contract_end_date:    b.frm.span(id: '').text.strip,
      # contract_extension_date: b.frm.span(id: '').text.strip,
      # contract_name_1:           b.frm.span(id: '').text.strip,
      # contract_po_limit:      b.frm.span(id: '').text.strip,
      # contract_campus_code:   b.frm.span(id: '').text.strip,
      # b2b_contract_indicator: b.frm.span(id: '').text.strip,
      # contract_manager_code:  b.frm.span(id: '').text.strip,
      # po_cost_source_code:     b.frm.span(id: '').text.strip,
      # vendor_pmt_terms_code:   b.frm.span(id: '').text.strip,
      # vendor_shipping_pmt_terms_code: b.frm.span(id: '').text.strip,
      # vendor_shipping_title_code:     b.frm.span(id: '').text.strip,
      general_liability_coverage_amt:    b.frm.span(id: '').text.strip,
      general_liability_expiration_date: b.frm.span(id: '').text.strip,
      automobile_liability_coverage_amt: b.frm.span(id: '').text.strip,
      insurance_req_complete:            b.frm.span(id: '').text.strip,
      automobile_liability_expiration_date: b.frm.span(id: '').text.strip,
      workman_liability_coverage_amt:       b.frm.span(id: '').text.strip,
      workman_liability_expiration_date:    b.frm.span(id: '').text.strip,
      excess_liability_umb_amt:             b.frm.span(id: '').text.strip,
      excess_liability_umb_expiration_date: b.frm.span(id: '').text.strip,
      health_offset_lic_expiration_date:    b.frm.span(id: '').text.strip,
      insurance_note:                       b.frm.span(id: '').text.strip,
      cornell_additional_ins_ind:           b.frm.span(id: '').text.strip,
      health_offsite_catering_lic_req:      b.frm.span(id: '').text.strip,
      insurance_requirements_complete:      b.frm.span(id: '').text.strip,
      insurance_requirement_indicator:      b.frm.span(id: '').text.strip,
      # TODO: Find a way to pull SupplierDiversities in during #absorb, by implementing #original_vendor_extended_data in the kuality-kfs-cu project
      # TODO: Find a way to pull Addresses in during #absorb
      # TODO: Find a way to pull Phone Numbers in during #absorb
      # TODO: Find a way to pull Notes and Attachments in during #absorb
      # TODO: Find a way to pull Search Aliases in during #absorb
    }.merge(b.respond_to?(:original_vendor_extended_data) ? b.original_vendor_extended_data : Hash.new)
  end
  value(:new_vendor_data) do |b|
    {
        # chart_code: b.chart_code.value,
        # number: b.number.value,
        # name: b.name.value,
        # organization_code: b.organization_code.value,
        # campus_code: b.campus_code.selected_options.first.text,
        # effective_date: b.effective_date.value,
        # postal_code: b.postal_code.value,
        # city: b.city.value,
        # state: b.state.value,
        # address: b.address.value,
        # type_code: b.type_code.selected_options.first.text,
        # sub_fund_group_code: b.sub_fund_group_code.value,
        # higher_ed_funct_code: b.higher_ed_funct_code.value,
        # restricted_status_code: b.restricted_status_code.selected_options.first.text,
        # fo_principal_name: b.fo_principal_name.value,
        # supervisor_principal_name: b.supervisor_principal_name.value,
        # manager_principal_name: b.manager_principal_name.value,
        # budget_record_level_code: b.budget_record_level_code.selected_options.first.text,
        # sufficient_funds_code: b.sufficient_funds_code.selected_options.first.text,
        # expense_guideline_text: b.expense_guideline_text.value,
        # income_guideline_text: b.income_guideline_text.value,
        # purpose_text: b.purpose_text.value,
        # income_stream_financial_cost_code: b.income_stream_financial_cost_code.selected_options.first.text,
        # income_stream_account_number: b.income_stream_account_number.value,
        # account_expiration_date: b.account_expiration_date.value,
        # # TODO: Make the next few lines grab every line of the ICRA data once we create a collection for ICRA data
        # indirect_cost_recovery_chart_of_accounts_code: b.frm.select(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryFinCoaCode').selected_options.first.text,
        # indirect_cost_recovery_account_number: b.frm.text_field(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryAccountNumber').value,
        # indirect_cost_recovery_account_line_percent: b.frm.text_field(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].accountLinePercent').value,
        # indirect_cost_recovery_active_indicator: yesno2setclear(b.frm.checkbox(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].active').value)
    }.merge(b.respond_to?(:new_vendor_extended_data) ? b.new_vendor_extended_data : Hash.new)
  end

  # Search Alias
  action(:add_search_alias) { |b| b.frm.button(id: 'methodToCall.addLine.vendorAliases.(!!org.kuali.kfs.vnd.businessobject.VendorAlias!!)').click }
  action(:show_search_aliases) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabSearchAlias').click }
  action(:delete_search_alias) { |i=0, b| b.frm.div(id: 'tab-SearchAlias-div').button(id: "methodToCall.deleteLine.vendorAliases.(!!.line#{i}").click }
  action(:search_alias_active) { |i=0, b| b.frm.div(id: 'tab-SearchAlias-div').checkbox(id: "document.newMaintainableObject.vendorAliases[#{i}].active").value }
  action(:search_alias_name) { |i=0, b| b.frm.div(id: 'tab-SearchAlias-div').span(id: "document.newMaintainableObject.vendorAliases[#{i}].vendorAliasName.div").text.strip }
  element(:new_search_alias_active) { |b| b.frm.checkbox(id: 'document.newMaintainableObject.add.vendorAliases.active') }
  element(:new_search_alias_name) { |b| b.frm.text_field(id: 'document.newMaintainableObject.add.vendorAliases.vendorAliasName') }
  action(:pull_existing_search_alias) do |i=0, b|
    {
      name:   b.search_alias_name(i),
      active: yesno2setclear(b.search_alias_active(i))
    }
  end
  value(:current_search_alias_count) { |b| b.frm.div(id: 'tab-SearchAlias-div').spans(class: 'left', text: /Search Alias [(]/m).length }

end
