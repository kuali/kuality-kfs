class RequisitionObject < KFSDataObject

  DOC_INFO = { label: 'Requisition', type_code: 'REQ' }

  attr_accessor :payment_request_positive_approval_required,
                # == Delivery Tab (Somewhat Incomplete) ==
                :delivery_campus, :delivery_building,
                :delivery_address_1, :delivery_address_2,
                :delivery_room, :delivery_city,
                :delivery_state, :delivery_postal_code, :delivery_country,
                :delivery_to, :delivery_phone_number, :delivery_email,
                :delivery_date_required, :delivery_date_required_reason,
                :delivery_instructions, # When does this actually get set?
                # == Additional Institutional Info Tab (Incomplete)==
                :requestor_phone,
                # == Vendor Tab (Incomplete) ==
                :vendor_notes

  def defaults
    # We'll merge the default_items so that our class defaults (specifically @initial_item_lines) override it
    super.merge(default_items)
         .merge({
                  delivery_building: '::random::',
                  requestor_phone:   random_phone_number,

                  # == Items (See ItemLinesMixin) ==
                  initial_item_lines: [Hash.new] # Add one initial item line, by default
                })
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_REQUISITION))
                        .merge(opts))
  end

  def build
    visit(MainPage).requisition
    on RequisitionPage do |page|
      expand_focus_and_clear page

      add_random_building_address if @delivery_building == '::random::'
      # TODO: Define a way to pick a non-random Delivery Building for RequisitionObject

      process_initial_item_lines # Necessary here because we want to calculate after adding Items/Item Accounting Lines

      page.calculate

      @delivery_phone_number = @requestor_phone if @delivery_phone_number.nil?
      fill_out page, :description, :payment_request_positive_approval_required,
                     :delivery_phone_number, :requestor_phone
    end
  end

  def save
    super
    @requisition_id = on(RequisitionPage).requisition_id # Requisition number is created only after a successful save
  end

  def add_vendor_to_req(vendor_num)
    on(RequisitionPage).suggested_vendor_search
    on VendorLookupPage do |page|
      page.vendor_number.wait_until_present
      page.vendor_number.fit vendor_num
      page.search
      page.return_value vendor_num
    end
  end

  def add_random_building_address
    on(RequisitionPage).building_search
    on(BuildingLookupPage).search_and_return_random
    on(RequisitionPage).room_search
    on(RoomLookupPage).search_and_return_random
    on RequisitionPage do |page|
      # Pull the results into the object
      @delivery_campus      = page.delivery_campus
      @delivery_building    = page.delivery_building
      @delivery_address_1   = page.delivery_address_1
      @delivery_address_2   = page.delivery_address_2.value
      @delivery_room        = page.delivery_room.value
      @delivery_city        = page.delivery_city
      @delivery_state       = page.delivery_state
      @delivery_postal_code = page.delivery_postal_code
      @delivery_country     = page.delivery_country
    end
  end

  include ItemLinesMixin

end #class