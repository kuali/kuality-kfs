module PaymentInformationMixin

  attr_accessor :payment_reason_code, :payee_id, :payee_name,
                :address_1, :address_2, :city, :state, :country,
                :postal_code, :check_amount, :due_date,
                :other_considerations_check_enclosure, :other_considerations_special_handling,
                :other_considerations_w9_completed, :other_considerations_exception_attached,
                :other_considerations_immediate_payment_indicator, :payment_method,
                :documentation_location_code, :check_stub_text
                :address_type_description

  def post_create
    super
    on PaymentInformationTab do |tab|
      choose_payee

      # These are returned to the page by choose_payee
      @payment_reason_code = tab.payment_reason_code.value
      @payee_name = tab.payee_name.value
      @address_1 = tab.address_1.value
      @address_2 = tab.address_2.value
      @city = tab.city.value
      @state = tab.state.value
      @country = tab.country.value
      @postal_code = tab.postal_code.value
      @due_date = tab.due_date.value
      @other_considerations_check_enclosure = tab.other_considerations_check_enclosure.value
      @other_considerations_special_handling = tab.other_considerations_special_handling.value
      @other_considerations_w9_completed = tab.other_considerations_w9_completed.value
      @other_considerations_exception_attached = tab.other_considerations_exception_attached.value
      @other_considerations_immediate_payment_indicator = tab.other_considerations_immediate_payment_indicator.value

      fill_out tab, :payment_method, :check_amount, :documentation_location_code, :check_stub_text
    end
  end

  # NOTE: This will only really work if you know the @payee_id and @address_type_description!
  def choose_payee
    on(KFSBasePage).search
    on PayeeLookup do |plookup| # TODO: Make PayeeLookup
      plookup.payment_reason_code.fit @payment_reason_code unless @payment_reason_code.nil?
      plookup.vendor_name.fit         @payee_name unless @payee_name.nil?
      plookup.vendor_number.fit       @payee_id unless @payee_id.nil?
      plookup.search

      plookup.return_value(@payee_id)
    end
    on VendorAddressLookup do |valookup| # TODO: Make VendorAddressLookup
      valookup.address_1.fit @address_1 unless @address_1.nil?
      valookup.address_2.fit @address_2 unless @address_2.nil?
      valookup.city.fit @city unless @city.nil?
      valookup.state.fit @state unless @state.nil?
      valookup.country.fit @country unless @country.nil?
      valookup.postal_code.fit @postal_code unless @postal_code.nil?
      valookup.address_type.fit @address_type_description unless @address_type_description.nil?

      valookup.search
      valookup.return_value(@address_type_description)
    end
  end

end