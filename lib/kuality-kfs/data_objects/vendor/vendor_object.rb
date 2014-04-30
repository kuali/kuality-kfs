class VendorObject < KFSDataObject

  attr_accessor :vendor_name, :vendor_last_name, :vendor_first_name , :vendor_type, :foreign,
                :tax_number,  :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none, :ownership, :w9_received,  :w9_received_date,
                :default_payment_method,

                :contract_name, :contract_description, :contract_begin_date, :contract_end_date, :contract_extension_date,

                :po_cost_source_code, :vendor_pmt_terms_code, :vendor_shipping_pmt_terms_code, :vendor_shipping_title_code,

                :contract_manager_code, :b2b_contract_indicator, :contract_po_limit,:contract_campus_code,

                :general_liability_coverage_amt, :general_liability_expiration_date, :automobile_liability_coverage_amt,
                :insurance_req_complete, :automobile_liability_expiration_date, :workman_liability_coverage_amt,:workman_liability_expiration_date,
                :excess_liability_umb_amt, :excess_liability_umb_expiration_date, :health_offset_lic_expiration_date, :insurance_note,
                :cornell_additional_ins_ind, :health_offsite_catering_lic_req,  :insurance_requirements_complete, :insurance_requirement_indicator,

                :contract_name_1,

                :search_aliases, :phone_numbers, :addresses, :contacts, :contracts,
                :supplier_diversities # FIXME: Move to kuality-kfs-cu project

  def defaults
    super.merge(
    {
      vendor_type:                'PO - PURCHASE ORDER',
      vendor_name:                'Keith, inc',
      foreign:                    'No',
      tax_number:                 "999#{rand(9)}#{rand(1..9)}#{rand(1..9999).to_s.rjust(4, '0')}",
      tax_number_type_ssn:        :set,
      ownership:                  'INDIVIDUAL/SOLE PROPRIETOR',
      w9_received:                'Yes',
      w9_received_date:           yesterday[:date_w_slashes],
      search_aliases:             collection('SearchAliasLineObject'),
      phone_numbers:              collection('PhoneLineObject'),
      addresses:                  collection('AddressLineObject'),
      contacts:                   collection('ContactLineObject'),
      supplier_diversities:       collection('SupplierDiversityLineObject') # FIXME: Move to kuality-kfs-cu project
    })
  end

  def build
    visit(MainPage).vendor
    on(VendorLookupPage).create_new

    on VendorPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :vendor_type, :vendor_name,:vendor_last_name,
                     :vendor_first_name, :foreign, :tax_number, :tax_number_type_fein,
                     :tax_number_type_ssn, :ownership, :w9_received, :w9_received_date,
                     :default_payment_method

      @addresses.add Hash.new # Need to send in an empty Hash so it'll just throw in whatever the default AddressLineObject is
      @supplier_diversities.add Hash.new # FIXME: Move to kuality-kfs-cu project
      #fill_out page, :supplier_diversity, :supplier_diversity_expiration_date

      page.add_supplier_diversity

      fill_out page, :insurance_requirements_complete, :cornell_additional_ins_ind

    end
  end

  def update_line_objects_from_page!
    super
    @phone_numbers.update_from_page!
    @addresses.update_from_page!
    @supplier_diversities.update_from_page! # FIXME: Copy this entire method to kuality-kfs-cu project, then remove this line here
  end

  def absorb(target={})
    super
    update_options(on(VendorPage).send("#{target.to_s}_vendor_data"))
  end

end