class RequisitionObject < KFSDataObject

  DOC_INFO = { label: 'Requisition', type_code: 'REQ' }

  attr_accessor :payment_request_positive_approval_required, :requisition_id,
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
                     :delivery_instructions, :delivery_phone_number,
                     :vendor_notes, :requestor_phone
    end
  end

  # Note: You'll need to update the subcollections separately.
  def update(opts={})
    on RequisitionPage do |page|
      edit_fields opts, page, :description, :payment_request_positive_approval_required,
                              :delivery_phone_number, :requestor_phone
    end
    update_options(opts)
  end
  alias_method :edit, :update

  def save
    super
    @requisition_id = on(RequisitionPage).requisition_id # Requisition number is created only after a successful save
  end

  def submit
    super
    @requisition_id = on(RequisitionPage).requisition_id # Requisition number is created only after a successful save, but it might be available now
  end

  def reload
    super
    @requisition_id = on(RequisitionPage).requisition_id # Requisition number is created only after a successful save, but it might be available now
  end

  def calculate
    on(RequisitionPage).calculate
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
    building_code = ''
    i = 0
    # make sure building has zip code and room
    while building_code.empty? && i < 10
      building_info = get_kuali_business_object('KFS-SYS','Building','active=true&campusCode='+ get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE))
      building_code = building_info['buildingCode'][0]
      if building_info['buildingAddressZipCode'][0] != 'null'
        begin
          room_info = get_kuali_business_object('KFS-SYS','Room',"buildingCode=#{building_code}")
        rescue
          # no room found
          building_code = ''
        end
      else
        building_code = ''
      end
      i += 1
    end

    on(RequisitionPage).building_search
    on BuildingLookupPage do |page|
      page.building_code.fit building_code
      page.search
      page.return_random
    end
    on(RequisitionPage).room_search
    on(RoomLookupPage).search_and_return_random
    update_options pull_delivery_tab(:new)
  end

  def absorb!(t=:new)
    super
    pulled_info = {}
    on RequisitionPage do |b|
      case t
        when :new
          pulled_info = {}
        when :readonly, :old
          pulled_info = {}
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end

      pulled_info.merge!(pull_delivery_tab(t))

    end
    pulled_info.delete_if { |k, v| v.nil? }

    update_options(pulled_info)
    update_line_objects_from_page!(t)
  end

  def pull_delivery_tab(t=:new)
    pulled_delivery_info = {}
    on RequisitionPage do |b|
      case t
        when :new
          pulled_delivery_info = {
            delivery_campus:        b.delivery_campus,
            delivery_building:      b.delivery_building,
            delivery_address_1:     b.delivery_address_1,
            delivery_address_2:     b.delivery_address_2.value,
            delivery_room:          b.delivery_room.value,
            delivery_city:          b.delivery_city,
            delivery_state:         b.delivery_state,
            delivery_postal_code:   b.delivery_postal_code,
            delivery_country:       b.delivery_country,
            delivery_to:            b.delivery_to.value,
            delivery_phone_number:  b.delivery_phone_number.value,
            delivery_email:         b.delivery_email.value,
            delivery_date_required: (b.delivery_date_required.value if b.delivery_date_required.exists?),
            delivery_date_required_reason: (b.delivery_date_required_reason.value if b.delivery_date_required_reason.exists?),
            delivery_instructions:  (b.delivery_instructions.value if b.delivery_instructions.exists?)
          }
        when :readonly, :old
          pulled_delivery_info = {
              delivery_campus:        b.result_delivery_campus,
              delivery_building:      b.result_delivery_building,
              delivery_address_1:     b.result_delivery_address_1,
              delivery_address_2:     b.result_delivery_address_2,
              delivery_room:          b.result_delivery_room,
              delivery_city:          b.result_delivery_city,
              delivery_state:         b.result_delivery_state,
              delivery_postal_code:   b.result_delivery_postal_code,
              delivery_country:       b.result_delivery_country,
              delivery_to:            b.result_delivery_to,
              delivery_phone_number:  b.result_delivery_phone_number,
              delivery_email:         b.result_delivery_email,
              delivery_date_required: b.result_delivery_date_required,
              delivery_date_required_reason: b.result_delivery_date_required_reason,
              delivery_instructions:  b.result_delivery_instructions
          }
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end
    end
    pulled_delivery_info.delete_if { |k, v| v.nil? }
  end

  include ItemLinesMixin

end