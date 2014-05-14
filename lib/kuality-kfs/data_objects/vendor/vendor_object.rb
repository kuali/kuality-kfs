class VendorObject < KFSDataObject

  attr_accessor :vendor_number, :vendor_name, :vendor_last_name, :vendor_first_name,
                :vendor_type, :foreign, :tax_number,
                :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none,
                :ownership, :w9_received,
                # == Collections ==
                :search_aliases, :phone_numbers, :addresses, :contacts, :contracts

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                random_alphanums(40, 'AFT'),
        vendor_type:                'PO - PURCHASE ORDER',
        vendor_name:                'Keith, inc',
        foreign:                    'No',
        tax_number:                 "999#{rand(9)}#{rand(1..9)}#{rand(1..9999).to_s.rjust(4, '0')}",
        tax_number_type_ssn:        :set,
        ownership:                  'INDIVIDUAL/SOLE PROPRIETOR',
        w9_received:                'Yes',
        w9_received_date:           yesterday[:date_w_slashes],
        address_type:               'PO - PURCHASE ORDER',
        address_1:                  get_generic_address_1,
        city:                       get_generi_city,
        state:                      get_random_state_code,
        zipcode:                    get_random_postal_code,
        country:                    'United States',
        default_address:            'Yes',
        method_of_po_transmission:  'US MAIL', #TODO replace with bootstrap data
        supplier_diversity:         'HUBZONE', #TODO replace with bootstrap data
        supplier_diversity_expiration_date: tomorrow[:date_w_slashes],
        attachment_file_name:       'vendor_attachment_test.png',
        note_text:                  random_alphanums(20, 'AFT')
    }

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_VENDOR)).merge(opts))
  end
  
  def defaults
    super.merge({
      vendor_type:         'PO - PURCHASE ORDER',
      vendor_name:         'Keith, inc',
      foreign:             'No',
      tax_number:          "999#{rand(9)}#{rand(1..9)}#{rand(1..9999).to_s.rjust(4, '0')}",
      tax_number_type_ssn: :set,
      ownership:           'INDIVIDUAL/SOLE PROPRIETOR',
      w9_received:         'Yes',
      search_aliases:      collection('SearchAliasLineObject'),
      phone_numbers:       collection('PhoneLineObject'),
      addresses:           collection('AddressLineObject'),
      contacts:            collection('ContactLineObject'),
      contracts:           collection('ContractLineObject')
    })
  end

  def build
    visit(MainPage).vendor
    on(VendorLookupPage).create_new
    on VendorPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description,
                     :vendor_name, :vendor_last_name, :vendor_first_name,
                     :vendor_type, :foreign, :tax_number,
                     :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none,
                     :ownership, :w9_received

      @addresses.add Hash.new # Need to send in an empty Hash so it'll just throw in whatever the default AddressLineObject is
    end
  end

  def update_line_objects_from_page!(target=:new)
    super
    @phone_numbers.update_from_page!(target)
    @addresses.update_from_page!(target)
    @contacts.update_from_page!(target)
    @contracts.update_from_page!(target)
    @search_aliases.update_from_page!(target)
    update_extended_line_objects_from_page!(target)
  end

  def absorb(target=:new)
    super
    on(VendorPage).expand_all
    case target
      when :new; update_options(pull_new_vendor_data)
      when :old; update_options(pull_old_vendor_data)
    end

    update_line_objects_from_page!(target)
  end

  # @return [Hash] The return values of attributes for the old Vendor
  def pull_old_vendor_data
    pulled_vendor = Hash.new
    on VendorPage do |vp|
      pulled_vendor = {
        vendor_number: vp.old_vendor_number,
        vendor_name:   vp.old_vendor_name,
        vendor_last_name:  vp.old_vendor_last_name,
        vendor_first_name: vp.old_vendor_first_name,
        vendor_type: vp.old_vendor_type,
        foreign:     vp.old_foreign,
        tax_number:  vp.old_tax_number,
        tax_number_type_fein: vp.old_tax_number_type_fein,
        tax_number_type_ssn:  vp.old_tax_number_type_ssn,
        tax_number_type_none: vp.old_tax_number_type_none,
        ownership:   vp.old_ownership,
        w9_received: vp.old_w9_received
      }
    end
    pulled_vendor.merge(pull_vendor_extended_data(:old))
  end

  # @return [Hash] The return values of attributes for the new Vendor
  def pull_new_vendor_data
    pulled_vendor = Hash.new
    on VendorPage do |vp|
      pulled_vendor = {
          vendor_number: vp.new_vendor_number,
          vendor_name: vp.new_vendor_name.value.strip,
          vendor_last_name:  vp.new_vendor_last_name.value.strip,
          vendor_first_name: vp.new_vendor_first_name.value.strip,
          vendor_type: vp.new_vendor_type.value.strip,
          foreign:     vp.new_foreign.selected_options.first.text.strip,
          tax_number:  vp.new_tax_number.value.strip,
          tax_number_type_fein: vp.new_tax_number_type_fein.value.strip,
          tax_number_type_ssn:  vp.new_tax_number_type_ssn.value.strip,
          tax_number_type_none: vp.new_tax_number_type_none.value.strip,
          ownership:   vp.new_ownership.selected_options.first.text.strip,
          w9_received: vp.new_w9_received.selected_options.first.text.strip
      }
    end
    pulled_vendor.merge(pull_vendor_extended_data(:new))
  end

  # @return [Hash] The return values of extended attributes for the old Vendor
  # @param [Symbol] target The set of Vendor data to pull in
  def pull_vendor_extended_data(target=:new)
    Hash.new
  end

end