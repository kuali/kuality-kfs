When /^I start an empty Vendor document$/ do
  @vendor = create VendorObject
end

And /^I add a Contract to the Vendor document$/ do
  @vendor.contracts.add Hash.new # This relies on defaults being specified for a Contract. May need revision/replacement to be more useful.
end

Then /^the Vendor document should be in my action list$/ do
  visit(MainPage).action_list
  sleep 3
  on ActionList do |page|
    page.close_parents
    page.sort_results_by('Id')
    page.sort_results_by('Id')
    page.result_item(@vendor.document_id).should exist
  end
end

And /^I edit a Vendor with Vendor Number (.*)$/ do |vendor_number|
  step "I lookup a Vendor with Vendor Number #{vendor_number}"
  on VendorPage do |page|
    page.description.fit random_alphanums(40, 'AFT')
    @vendor = make VendorObject, description: page.description.text.strip,
                   document_id: page.document_id
    @vendor.absorb! :old
    @document_id = @vendor.document_id
    page.default_payment_method.fit 'P - ACH/CHECK' if page.default_payment_method.value.empty?
  end
end

And /^I edit a Vendor with Ownership Type (.*)$/ do |ownership_type|
  vendor_info = get_kuali_business_object('KFS-VND','VendorDetail','vendorHeader.vendorOwnershipCode=' + ownership_type)
  vendor_number = vendor_info['vendorNumber'][0]
  step "I edit a Vendor with Vendor Number #{vendor_number}"
end

And /^the Tax Number and Notes are Not Visible on Vendor page$/ do
  on VendorPage do |page|
    page.notes_table.rows.length.should == 2 # no notes displayed
    # can't locate this table with id/name/summary, so do this ugly way? # tax number is masked
    page.ownership.parent.parent.parent.parent[11][3].text == '*********'
  end
end

And /^I change the Phone (\w+) on Vendor Phone tab$/ do |phone_field|
  on VendorPage do |page|
    page.expand_all
    if page.updated_phone_number.exists?
      case phone_field
        when 'Number'
          @vendor.phone_numbers.first.edit number: "607-#{rand(100..999)}-#{rand(1000..9999)}"
        when 'Extension'
          @vendor.phone_numbers.first.edit extension: rand(100..999)
        when 'Type'
          current_selection = @vendor.phone_numbers.first.type
          @vendor.phone_numbers.first.edit type: '::random::'
          while current_selection == @vendor.phone_numbers.first.type
            @vendor.phone_numbers.first.edit type: '::random::' # Try again if the random selector picked the current value
          end
      end
    else
      @vendor.phone_numbers.add number: "607-#{rand(100..999)}-#{rand(1000..9999)}", type: 'SALES'
    end
  end
end

And /^I change the Address (\w+) ?(\d)? on Vendor Address tab$/ do |line_or_attention, which_line|
  on VendorPage do |page|
    case line_or_attention
      when 'Line'
        case which_line
          when 1
            @vendor.addresses.first.edit address_1: random_alphanums(30, 'AFT')
          when 2
            @vendor.addresses.first.edit address_2: random_alphanums(30, 'AFT')
        end
      when 'Attention'
        @vendor.addresses.first.edit attention: random_alphanums(20, 'AFT')
    end
  end
end

When /^I select Vendor document from my Action List$/ do
  visit(MainPage).action_list
  on(ActionList).last if on(ActionList).last_link.exists? && !on(ActionList).result_item(@vendor.document_id).exists?
  on(ActionList).open_item(@vendor.document_id)
end

And /^the Address and Phone Number changes persist$/ do
  on VendorPage do |page|
    page.expand_all
    page.updated_address_1.value.strip.should == @vendor.addresses.first.address_1
    page.updated_phone_type.selected_options.first.text.should == @vendor.phone_numbers.first.type
    page.updated_address_2.value.strip.should == @vendor.addresses.first.address_2
    page.updated_phone_number.value.strip.should == @vendor.phone_numbers.first.number.to_s
    page.updated_address_attention.value.strip.should == @vendor.addresses.first.attention
    page.updated_phone_ext.value.strip.should == @vendor.phone_numbers.first.extension.to_s
  end
end

And /^I add an Address to a Vendor with following fields:$/ do |table|
  vendor_address = table.rows_hash
  vendor_address.delete_if { |k,v| v.empty? }
  @vendor.addresses.add type:        vendor_address['Address Type'] ||= '',
                        address_1:   vendor_address['Address 1'] ||= '',
                        address_2:   vendor_address['Address 2'] ||= '',
                        city:        vendor_address['City'] ||= '',
                        state:       vendor_address['State'] ||= '',
                        postal_code: vendor_address['Zip Code'] ||= '',
                        province:  vendor_address['Province'] ||= '',
                        country:   vendor_address['Country'] ||= '',
                        attention: vendor_address['Attention'] ||= '',
                        url:    vendor_address['URL'] ||= '',
                        fax:    vendor_address['Fax'] ||= '',
                        email:  vendor_address['Email'] ||= '',
                        active: yesno2setclear(vendor_address['Active'] ||= 'YES'),
                        set_as_default: vendor_address['Set As Default?'] ||= 'No',
                        method_of_po_transmission: vendor_address['Method of PO Transmission'] ||= '' # Cornell-specific mod
  @added_address = @vendor.addresses.find_all do |addr|
    addr.type == (vendor_address['Address Type'] ||= '') and
        addr.address_1 == (vendor_address['Address 1'] ||= '') and
        addr.address_2 == (vendor_address['Address 2'] ||= '') and
        addr.city == (vendor_address['City'] ||= '') and
        addr.state == (vendor_address['State'] ||= '') and
        addr.postal_code == (vendor_address['Zip Code'] ||= '') and
        addr.province == (vendor_address['Province'] ||= '') and
        addr.country == (vendor_address['Country'] ||= '') and
        addr.attention == (vendor_address['Attention'] ||= '') and
        addr.url == (vendor_address['URL'] ||= '') and
        addr.fax == (vendor_address['Fax'] ||= '') and
        addr.email == (vendor_address['Email'] ||= '') and
        addr.active == (yesno2setclear(vendor_address['Active'] ||= 'YES')) and
        addr.set_as_default == (vendor_address['Set As Default?'] ||= 'No') and
        addr.method_of_po_transmission == (vendor_address['Method of PO Transmission'] ||= '')
  end.sort{|a, b| a.line_number <=> b.line_number}.last
end

And /^I update the General Liability with expired date$/ do
  @changed_liability = {} if @changed_liability.nil?
  on VendorPage do |page|
    page.expand_all
    page.insurance_requirements_complete.fit 'Yes'
    page.cornell_additional_ins_ind.fit 'Yes'
    page.insurance_requirement_indicator.set
    page.general_liability_coverage_amt.fit '100.00'
    page.general_liability_expiration_date.fit yesterday[:date_w_slashes]
    @changed_liability.merge!(general_liability_coverage_amt: page.general_liability_coverage_amt.value)
    @changed_liability.merge!(general_liability_expiration_date: page.general_liability_expiration_date.value)
  end
end

When /^I (#{BasePage::available_buttons}) the Vendor document with expired liability date$/ do |button|
  #doc_object = snake_case document
  button.gsub!(' ', '_')
  @vendor.send(button)
  on(YesOrNoPage).yes
  sleep 10 if (button == 'blanket approve' || button == 'approve' || 'submit')
end

When /^I close and save the Vendor document$/ do
  on(VendorPage).close
  on(YesOrNoPage).yes
end

And /^the changes to Vendor document have persisted$/ do
  step 'the Address and Phone Number changes persist'
  unless @changed_liability.nil?
    on VendorPage do |page|
      page.general_liability_coverage_amt.value.should == @changed_liability[:general_liability_coverage_amt]
      page.general_liability_expiration_date.value.should == @changed_liability[:general_liability_expiration_date]
    end
  end
end

And /^I can not view the Tax ID and Attachments on Vendor page$/ do
  on VendorPage do |page|
    page.hidden_tax_number.parent.text.should include ('Tax Number: *********')
    page.notes_table.rows.length.should == 2
  end
end

And /^I enter a default payment method (\w+) on Vendor Page$/ do |payment_method|
  sleep 1
  on(VendorPage).default_payment_method.fit payment_method
  # TODO: FIXME: Should probably use the VendorObject#edit method...
  @vendor.default_payment_method = payment_method
end

And /^the Address changes persist$/ do
  on VendorPage do |page|
    page.expand_all
    page.updated_address_1.value.should == @vendor.addresses[0].address_1
    page.updated_2nd_address_2.value.should == @vendor.addresses[1].address_2
  end
end

And /^I change Remit Address and the Foreign Tax Address$/ do
  @vendor.addresses[0].edit address_1: random_alphanums(30, 'AFT')
  @vendor.addresses[1].edit address_2: random_alphanums(30, 'AFT')
end

And /^I lookup a Vendor with Vendor Number (.*)$/ do |vendor_number|
  visit(MainPage).vendor
  on VendorLookupPage do |page|
    page.active_indicator_yes.set
    page.vendor_number.fit vendor_number
    page.search
    page.edit_item vendor_number # This should throw a fail if the item isn't found.
  end
end

And /^I open the Vendor from the Vendor document$/ do
  visit(MainPage).vendor
  on VendorLookupPage do |page|
    page.vendor_number.fit @vendor.vendor_number
    page.search
    page.open_item_via_text @vendor.vendor_name, @vendor.vendor_name # This should throw a fail if the item isn't found.
  end
end

And /^I lookup a PO Vendor$/ do
  vendor_info = get_kuali_business_object('KFS-VND','VendorDetail','vendorHeader.vendorTypeCode=PO')
  vendor_number = vendor_info['vendorNumber'][0]

  step "I lookup a Vendor with Vendor Number #{vendor_number}"
end

And /^I lookup a PO Vendor with Supplier Diversity$/ do
  vendors = get_kuali_business_objects('KFS-VND','VendorDetail','vendorHeader.vendorOwnershipCode=ID&vendorHeader.vendorSupplierDiversities.vendorSupplierDiversityCode=WO&vendorHeader.vendorSupplierDiversities.extension.vendorSupplierDiversityExpirationDate=07/25/2014&active=Y&vendorNumber=*-0')
  vendor_info = vendors.values[0].sample
  until vendor_info['vendorNumber'][0].end_with? '-0'
    vendor_info = vendors.values[0].sample
  end
  vendor_number = vendor_info['vendorNumber'][0]

  step "I lookup a Vendor with Vendor Number #{vendor_number}"
end

And /^I edit a PO Vendor$/ do
  step 'I lookup a PO Vendor'
  @vendor = make VendorObject
  on(VendorPage).description.fit @vendor.description
  @vendor.absorb! :old
  @document_id = @vendor.document_id
end

And /^I edit a PO Vendor with Supplier Diversity$/ do
  step 'I lookup a PO Vendor with Supplier Diversity'
  @vendor = make VendorObject
  on(VendorPage).description.fit @vendor.description
  @vendor.absorb! :old
  @document_id = @vendor.document_id
end

And /^I add a Search Alias to the Vendor document$/ do
  @vendor.search_aliases.update_from_page!
  @vendor.search_aliases.add Hash.new # We'll just add the default value.
  # For some reason, we still need to provide an empty hash.
end

And /^I add a Supplier Diversity to the Vendor document$/ do
  @vendor.supplier_diversities.update_from_page!
  @vendor.supplier_diversities.add Hash.new # We'll just add the default value.
  # For some reason, we still need to provide an empty hash.
end

Then /^the Address Tab displays Vendor Address Generated Identifiers for each Address$/ do
  on VendorPage do |vp|
    @vendor.addresses.each do |addr|
      vp.vendor_address_generated_identifier(addr.line_number).nil?.should_not
      addr.vendor_address_generated_identifier = vp.vendor_address_generated_identifier(addr.line_number) # Let's load this in, just in case
    end
  end
end

When /^I change the (.*) document's (.*) field to today$/ do |document, date_field|
  new_date = right_now[:date_w_slashes]
  on(page_class_for(document)).send(snake_case(date_field)).fit new_date
  document_object_for(document).set(date_field, new_date)

  on(page_class_for(document)).send(snake_case(date_field)).value.should == new_date
  document_object_for(document).send(snake_case(date_field)).should == new_date
end

Then /^the default Purchase Order Vendor address\(es\) are shown on the (.*) document$/ do |document|
  # We're only interested in comparing the addresses here, so we'll pull them
  # from the page and only look at that data. If this step is expanded, we can
  # modify VendorObject#absorb appropriately and switch to using that method
  # instead of #update_from_page!
  vendor_on_page = make VendorObject
  vendor_on_page.addresses.update_from_page! :readonly
  vendor_on_page.addresses.eql?(document_object_for(document).addresses).true?.should
end

And /^I edit a Vendor with an active Contract$/ do
  step 'I lookup a Vendor with an active Contract'
  @vendor = make VendorObject
  on(VendorPage).description.fit @vendor.description
  @vendor.absorb! :old
  @document_id = @vendor.document_id
end

And /^I lookup a Vendor with an active Contract$/ do
  vendor_contract = get_kuali_business_object('KFS-VND','VendorContract','active=Y&vendorDetailAssignedIdentifier=0')
  vendor_header_id = vendor_contract['vendorHeaderGeneratedIdentifier'].sample
  step "I lookup a Vendor with Vendor Number #{vendor_header_id}-0"
end

And /^I edit a contract on Vendor Contract tab$/ do
  contract_name = random_alphanums(15, 'AFT')
  description = random_alphanums(40, 'AFT')
  campus_code = get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_CODE)
  begin_date = right_now[:date_w_slashes]
  end_date = in_a_year[:date_w_slashes]
  manager = get_kuali_business_object('KFS-VND','ContractManager','active=Y')['contractManagerName'].sample
  po_cost_source = get_kuali_business_object('KFS-VND','PurchaseOrderCostSource','active=Y')['purchaseOrderCostSourceDescription'].sample
  payment_terms = get_kuali_business_object('KFS-VND','PaymentTermType','active=Y')['vendorPaymentTermsDescription'].sample
  @vendor.contracts.first.edit name: contract_name,
                               description: description,
                               campus_code: campus_code,
                               begin_date: begin_date,
                               end_date: end_date,
                               manager: manager,
                               po_cost_source: po_cost_source,
                               payment_terms: payment_terms
  on VendorPage do |vp|
    vp.update_contract_name.value.should == contract_name
    vp.update_contract_description.value.should == description
    vp.update_contract_campus_code.selected_options.first.text.should == campus_code
    vp.update_contract_begin_date.value.should == begin_date
    vp.update_contract_end_date.value.should == end_date
    vp.update_contract_manager.selected_options.first.text.should == manager
    vp.update_contract_po_cost_source.selected_options.first.text.should == po_cost_source
    vp.update_contract_payment_terms.selected_options.first.text.should == payment_terms
  end
end
