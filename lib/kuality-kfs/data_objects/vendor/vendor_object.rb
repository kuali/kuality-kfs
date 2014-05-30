class VendorObject < KFSDataObject

  attr_accessor :vendor_number, :vendor_name, :vendor_last_name, :vendor_first_name,
                :vendor_type, :foreign, :tax_number,
                :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none,
                :ownership, :w9_received,
                # == Collections ==
                :search_aliases, :phone_numbers, :addresses, :contacts, :contracts

  def defaults
    super.merge({
      vendor_type:         'PO - PURCHASE ORDER',
      vendor_name:         'Keith, inc',
      foreign:             'No',
      tax_number:          random_tax_number,
      tax_number_type_ssn: :set, # If this default is changed, you must update #sync_tax_number_type
      ownership:           'INDIVIDUAL/SOLE PROPRIETOR',
      w9_received:         'Yes',
      search_aliases:      collection('SearchAliasLineObject'),
      phone_numbers:       collection('PhoneLineObject'),
      addresses:           collection('AddressLineObject'),
      contacts:            collection('ContactLineObject'),
      contracts:           collection('ContractLineObject')
    }).merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_VENDOR))
  end

  def build
    visit(MainPage).vendor
    on(VendorLookupPage).create_new
    on VendorPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      sync_tax_number_type

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

  private

  # We want the tax number types to either be :set or :clear, but only one can
  # be :set at a time since this is a radio. This should update the other two
  # when one is set.
  def sync_tax_number_type
    # The first time through, the default value is @tax_number_type_ssn == :set
    # and the others set to nil. After that, everything should be synched.
    if @tax_number_type_fein.nil? || @tax_number_type_none.nil?
      raise ArgumentError 'Only one Tax Number Type can be :set at a time!' if (@tax_number_type_fein == :set && @tax_number_type_ssn == :set) ||
                                                                               (@tax_number_type_fein == :set && @tax_number_type_none == :set) ||
                                                                               (@tax_number_type_ssn == :set && @tax_number_type_none == :set)
    end

    # We rely on that knowledge of the default to choose the setting here.
    if @tax_number_type_fein == :set
      @tax_number_type_ssn = :clear
      @tax_number_type_none = :clear
    elsif @tax_number_type_ssn == :set
      @tax_number_type_fein = :clear
      @tax_number_type_none = :clear
    elsif @tax_number_type_none == :set
      @tax_number_type_ssn = :clear
      @tax_number_type_fein = :clear
    end
  end

end