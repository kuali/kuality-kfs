class RequisitionObject < KFSDataObject

  #DOC_INFO = { label: 'Requisition', type_code: 'REQ' }
  attr_accessor :description, :item_account_number, :item_object_code, :item_catalog_number, :item_description, :item_unit_cost, :item_quantity, :item_uom, :attachment_file_name, :building_address, :requestor_phone,
                :delivery_instructions, :vendor_notes, :item_commodity_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(40, 'AFT'),
        item_quantity: '1000',
        item_catalog: random_alphanums(7, 'AFT'),
        item_description: random_alphanums(15, 'AFT Item'),
        item_unit_cost: '9.9',
        item_uom: 'BX',#TODO grab randome from service
        attachment_file_name:       'happy_path_reqs.png',
        building_address: 'random',
        requestor_phone: rand(99..999).to_s + '-' + rand(99..999).to_s + '-' + rand(999..9999).to_s
    }

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_REQUISITION)).merge(opts))
  end

  def build
    visit(MainPage).requisition
    on RequisitionPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      add_random_building_address(page) if @building_address == 'random'

      #Add Item
      fill_out page, :item_quantity, :item_catalog_number, :item_commodity_code, :item_description, :item_unit_cost, :item_restricted, :item_assigned, :item_uom
      page.item_add
      fill_out page, :description

      #Add Accounting line
      fill_out page, :item_account_number, :item_object_code, :item_percent
      page.item_add_account_line

      page.requestor_phone.fit @requestor_phone
      page.delivery_phone_number.fit @requestor_phone
      #wait? for balance Perform Balance Inquiry for Source Accounting Line 1
      page.balance_inquiry_button.wait_until_present
      page.calculate


      # @requisition_id = page.requisition_id
      #Requisition number is created only after a successful submit
    end
  end

  def add_vendor_to_req(vendor_num)
    on(RequisitionPage).suggested_vendor_search
    on VendorLookupPage do |page|
      page.vendor_number.wait_until_present
      page.vendor_number.fit vendor_num
      page.search
      page.return_value(vendor_num)
    end
  end

  def add_random_building_address(page)
    page.building_search
    on BuildingLookupPage do |page|
      page.search
      page.return_random
    end
    page.room_search
    on RoomLookupPage do |page|
      page.search
      page.return_random
    end
  end

end #class