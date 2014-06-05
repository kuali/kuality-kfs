module PaymentInformationMixin

  attr_accessor :payment_reason_code, :payee_id, :payee_name,
                :address_1, :address_2, :city, :state, :country,
                :postal_code, :check_amount, :due_date,
                :other_considerations_check_enclosure, :other_considerations_special_handling,
                :other_considerations_w9_completed, :other_considerations_exception_attached,
                :other_considerations_immediate_payment_indicator, :payment_method,
                :documentation_location_code, :check_stub_text,
                :address_type_description, :vendor_payee

  alias :vendor_payee? :vendor_payee
  def default_payment_information_lines(opts={})
    {
        payment_reason_code: 'B - Reimbursement for Out-of-Pocket Expenses',
        check_amount:        '100.00',
        #due_date:            '',
        #other_considerations_check_enclosure:    '',
        #other_considerations_special_handling:   '',
        #other_considerations_w9_completed:       '',
        #other_considerations_exception_attached: '',
        #other_considerations_immediate_payment_indicator: '',
        payment_method:              'P - ACH/CHECK',#'F - Foreign Draft',
        #documentation_location_code: '',
        check_stub_text:             'test, Check Stub',
        address_type_description:    'TX - TAX',
        vendor_payee:                true
    }.merge(opts)
  end

  def post_create
    super
    on (PaymentInformationTab) do |tab|
      unless @payee_id.nil?
        choose_payee
        fill_in_payment_info(tab)
      end
    end
  end

  def fill_in_payment_info(tab)
    # These are returned to the page by choose_payee
    @payment_reason_code = tab.payment_reason_code
    @payee_name = tab.payee_name
    @address_1 = tab.address_1.value
    @address_2 = tab.address_2.value
    @city = tab.city.value
    @state = tab.state.value
    @country = tab.country.selected_options.first.text
    @postal_code = tab.postal_code.value
    @due_date = tab.due_date.value
    @other_considerations_check_enclosure = (tab.other_considerations_check_enclosure.exists? ? tab.other_considerations_check_enclosure.value : 'No')
    @other_considerations_special_handling = (tab.other_considerations_special_handling.exists? ? tab.other_considerations_special_handling.value : 'No')
    @other_considerations_w9_completed = (tab.other_considerations_w9_completed.exists? ? tab.other_considerations_w9_completed.value : 'No')
    @other_considerations_exception_attached = (tab.other_considerations_exception_attached.exists? ? tab.other_considerations_exception_attached.value : 'No')
    @other_considerations_immediate_payment_indicator = (tab.other_considerations_immediate_payment_indicator.exists? ? tab.other_considerations_immediate_payment_indicator.value : 'No')
    @documentation_location_code = tab.documentation_location_code.selected_options.first.text

    fill_out tab, :payment_method, :check_amount, :documentation_location_code, :check_stub_text
  end
  # NOTE: This will only really work if you know the @payee_id and @address_type_description!
  def choose_payee
    on(PaymentInformationTab).payee_search
    on PayeeLookup do |plookup|
      plookup.payment_reason_code.fit @payment_reason_code unless @payment_reason_code.nil?
      plookup.vendor_name.fit         @payee_name unless @payee_name.nil?
      if vendor_payee? # payee can be a 'vendor' or 'employee'
        plookup.vendor_number.fit       @payee_id unless @payee_id.nil?
      else
        plookup.netid.fit       @payee_id unless @payee_id.nil?
      end

      plookup.search
      plookup.return_value(@payee_id)
    end

      if on(Lookups).on_a_lookup? && (on(Lookups).lookup_title == 'Vendor Address Lookup')
        on VendorAddressLookup do |valookup|
          valookup.address_1.fit @address_1 unless @address_1.nil?
          valookup.address_2.fit @address_2 unless @address_2.nil?
          valookup.city.fit @city unless @city.nil?
          valookup.state.fit @state unless @state.nil?
          valookup.country.fit @country unless @country.nil?
          valookup.postal_code.fit @postal_code unless @postal_code.nil?
          valookup.address_type.fit @address_type_description unless @address_type_description.nil?

          valookup.search
          valookup.return_value_links.first.click
        end
      end
    end

end