class VendorObject < KFSDataObject

  attr_accessor :vendor_name, :vendor_last_name, :vendor_first_name , :vendor_type, :foreign,
      :tax_number,  :tax_number_type_fein, :tax_number_type_ssn, :tax_number_type_none,
      :ownership, :w9_received,  :address_type, :address_1, :address_2,
      :city, :state, :zipcode, :country, :default_address,
      :supplier_diversity, :w9_received_date, :supplier_diversity_expiration_date, :method_of_po_transmission,
      :attachment_file_name, :note_text, :attach_notes_file

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:            random_alphanums(40, 'AFT'),
        vendor_type:   'PO - PURCHASE ORDER',
        vendor_name: 'Keith, inc',
        foreign: 'No',
        tax_number:  "999#{rand(9)}#{rand(1..9)}#{rand(1..9999).to_s.rjust(4, '0')}",
        tax_number_type_ssn:   :set,
        ownership: 'INDIVIDUAL/SOLE PROPRIETOR',
        w9_received: 'Yes',
        w9_received_date: yesterday[:date_w_slashes],
        address_type: 'PO - PURCHASE ORDER',
        address_1: '6655 Sunset BLvd',
        city: 'Denver',
        state: 'CO',
        zipcode: '91190',
        country: 'United States',
        default_address: 'Yes',
        method_of_po_transmission: 'US MAIL',
        supplier_diversity: 'HUBZONE',
        supplier_diversity_expiration_date: tomorrow[:date_w_slashes],
        attachment_file_name: 'vendor_attachment_test.png',
        note_text: random_alphanums(20, 'AFT')
        #press:                       :save
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
      #page.supplier_diversity_expiration_date.fit @supplier_diversity_expiration_date.to_s
      page.add_supplier_diversity



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