class VendorObject < KFSDataObject

  attr_accessor :vendor_name, :vendor_last_name, :vendor_first_name , :vendor_type, :foreign,
      :tax_number,  :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none,
      :ownership, :w9_received,  :address_type, :address_1, :address_2,
      :city, :state, :zipcode, :country, :default_address,
      :supplier_diversity, :w9_received_date, :supplier_diversity_expiration_date, :method_of_po_transmission,
      :attachment_file_name, :note_text, :attach_notes_file, :contract_name, :contract_description, :contract_begin_date, :contract_end_date,
      :contract_extension_date, :contract_po_limit, :general_liability_coverage_amt, :general_liability_expiration_date, :automobile_liability_coverage_amt,
      :automobile_liability_expiration_date, :workman_liability_coverage_amt,:workman_liability_expiration_date, :excess_liability_umb_amt,
      :excess_liability_umb_expiration_date, :health_offset_lic_expiration_date, :insurance_note, :contract_manager_code, :b2b_contract_indicator,
      :po_cost_source_code, :vendor_pmt_terms_code, :vendor_shipping_pmt_terms_code, :vendor_shipping_title_code, :insurance_req_complete,
      :cornell_additional_ins_ind, :health_offsite_catering_lic_req, :contract_campus_code, :insurance_requirements_complete, :insurance_requirement_indicator

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
        address_1:                  '6655 Sunset BLvd',
        city:                       'Denver',
        state:                      'CO',
        zipcode:                    '91190',
        country:                    'United States',
        default_address:            'Yes',
        method_of_po_transmission:  'US MAIL',
        supplier_diversity:         'HUBZONE',
        supplier_diversity_expiration_date: tomorrow[:date_w_slashes],
        attachment_file_name:       'vendor_attachment_test.png',
        note_text:                  random_alphanums(20, 'AFT'),
        contract_po_limit:          '100000',
        contract_name:              'MH Drums',
        contract_description:       'MH Drums Master Agreement',
        contract_begin_date:        '02/05/2014',
        contract_end_date:          '02/05/2016',
        contract_campus_code:       'IT - Ithaca',
        contract_manager_code:      'Scott Otey',
        po_cost_source_code:        'Pricing Agreement',
        b2b_contract_indicator:     'No',
        vendor_pmt_terms_code:      'Net 5 Days',
        insurance_requirements_complete:      'Yes',
        general_liability_coverage_amt:       '100',
        general_liability_expiration_date:    tomorrow[:date_w_slashes],
        general_liability_coverage_amt:       '100',
        general_liability_expiration_date:    tomorrow[:date_w_slashes],
        automobile_liability_coverage_amt:    '100',
        automobile_liability_expiration_date: tomorrow[:date_w_slashes],
        workman_liability_coverage_amt:       '100',
        workman_liability_expiration_date:    tomorrow[:date_w_slashes],
        excess_liability_umb_amt:             '100',
        excess_liability_umb_expiration_date: tomorrow[:date_w_slashes],
        health_offsite_catering_lic_req:      'Yes',
        health_offset_lic_expiration_date:    tomorrow[:date_w_slashes],
        insurance_note:                       random_alphanums(240),
        insurance_requirement_indicator:      :set

    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).vendor
    on(VendorLookupPage).create_new

    on VendorPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...


      fill_out page, :description, :vendor_type, :vendor_name, :foreign, :tax_number , :tax_number_type_ssn,
         :ownership, :w9_received, :w9_received_date


      fill_out page,  :address_type, :address_1, :city, :state, :zipcode,
               :country, :default_address, :method_of_po_transmission
      page.add_address

      fill_out page, :supplier_diversity, :supplier_diversity_expiration_date

      page.add_supplier_diversity

      fill_out page, :contract_po_limit, :contract_name, :contract_description, :contract_begin_date, :contract_end_date,
               :contract_campus_code, :contract_manager_code, :b2b_contract_indicator, :vendor_pmt_terms_code

      page.add_vendor_contract
    end
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      search.open_doc @document_id
    end
  end

end