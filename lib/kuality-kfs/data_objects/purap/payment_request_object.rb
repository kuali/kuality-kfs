class PaymentRequestObject < KFSDataObject

  DOC_INFO = { label: 'Payment Request', type_code: 'PREQ', transactional?: true }

  include ProcessItemsAccountingLinesMixin

  attr_accessor :number,
                # == Payment Request Detail ==
                :account_distribution_method, :payment_request_positive_approval_required,
                # == Vendor (Incomplete) ==
                :vendor_name, :vendor_number, :vendor_address_1, :vendor_address_2, :attention,
                :vendor_city, :vendor_state, :vendor_province, :vendor_postal_code, :vendor_country,
                # == Invoice Info ==
                :purchase_order_number, :pay_date, :bank_code,
                :invoice_date, :invoice_number, :vendor_invoice_amount,
                :payment_method_code,
                # == Process Items ==
                :freight_extended_cost, :freight_description,
                :misc_extended_cost, :misc_description,
                :sh_extended_cost, :sh_description,
                :close_po,
                # == Tax Tab ==
                :income_class_code, :federal_tax_pct, :state_tax_pct, :postal_country_code


  def defaults
    super.merge(default_additional_charges_accounting_lines)
         .merge(default_items)
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PAYMENT_REQUEST))
                        .merge(opts))
  end

  def build
    visit(MainPage).payment_request
    initiate_request

    on PaymentRequestPage do |page|
      # Lots of data is prefilled on a PREQ.
      absorb! :new
      fill_out page, :vendor_address_1, :pay_date
                      # == Not yet implemented in PaymentRequestPage: ==
                      # :account_distribution_method, :payment_request_positive_approval_required,
                      # :vendor_name, :vendor_number, :vendor_address_2, :attention,
                      # :vendor_city, :vendor_state, :vendor_province, :vendor_postal_code, :vendor_country,
                      # :purchase_order_number, :bank_code,
                      # :invoice_date, :invoice_number, :vendor_invoice_amount,
                      # :payment_method_code,
                      # :freight_extended_cost, :freight_description,
                      # :misc_extended_cost, :misc_description,
                      # :sh_extended_cost, :sh_description,
                      # :close_po
    end

  end

  # Fills out the Payment Request Initiation page that is the first step of creating a Payment Request
  def initiate_request
    on PaymentRequestInitiationPage do |page|
      fill_out page, :purchase_order_number,
                     :invoice_date, :invoice_number, :vendor_invoice_amount
      page.continue
      sleep 120 # This transition can take a long time. We'll sleep for 2 minutes, at least
    end
    on(YesOrNoPage).yes_if_possible # Sometimes it will ask for confirmation
    @number = on(PaymentRequestPage).preq_id
  end

  # Fills out the Payment Request's tax tab. This should not be done during an edit,
  # @param [Hash] opts Elements to update
  def update_tax_tab(opts={})
    on PaymentRequestPage do |page|
      edit_fields opts, page, :income_class_code, :federal_tax_pct, :state_tax_pct, :postal_country_code
    end
    update_options(opts)
  end

  # Note: You'll need to update the subcollections (e.g. Items) separately.
  # @param [Hash] opts Elements to update
  def update(opts={})
    super
    on PaymentRequestPage do |page|
      edit_fields opts, page, :vendor_address_1, :pay_date
                              # == Not yet implemented in PaymentRequestPage: ==
                              # :account_distribution_method, :payment_request_positive_approval_required,
                              # :vendor_name, :vendor_number, :vendor_address_2, :attention,
                              # :vendor_city, :vendor_state, :vendor_province, :vendor_postal_code, :vendor_country,
                              # :purchase_order_number, :bank_code,
                              # :invoice_date, :invoice_number, :vendor_invoice_amount,
                              # :payment_method_code,
                              # :freight_extended_cost, :freight_description,
                              # :misc_extended_cost, :misc_description,
                              # :sh_extended_cost, :sh_description,
                              # :close_po
    end
    update_options(opts)
  end
  alias_method :edit, :update

  # Pull information from the page into the object. Note: this will not work for the PREQ initiation page!
  # @param [Symbol] target The set of PREQ data to pull in
  def absorb!(target=:new)
    super
    on(PaymentRequestPage).expand_all
    case target
      when :new; update_options(pull_new_preq_data)
      when :old; update_options(pull_old_preq_data)
      else
        raise ArgumentError, "PaymentRequestObject#absorb! does not recognize the specified mode (#{target})."
    end

    update_line_objects_from_page!(target)
  end

  # @return [Hash] The return values of attributes for the old PREQ
  def pull_old_preq_data
    pulled_preq = Hash.new
    on PaymentRequestPage do |prp|
      pulled_preq = {
        vendor_address_1: prp.result_vendor_address_1,
        pay_date:         prp.pay_date.value.strip
      }
    end
    pulled_preq.merge(pull_preq_extended_data(:old))
  end

  # @return [Hash] The return values of attributes for the new PREQ
  def pull_new_preq_data
    pulled_preq = Hash.new
    on PaymentRequestPage do |prp|
      pulled_preq = {
        vendor_address_1: prp.vendor_address_1.value.strip,
        pay_date:         prp.pay_date.value.strip
      }
    end
    pulled_preq.merge(pull_preq_extended_data(:new))
  end

  # @return [Hash] The return values of extended attributes for the old PREQ
  # @param [Symbol] target The set of PREQ data to pull in
  def pull_preq_extended_data(target=:new)
    Hash.new
  end

  def save
    @number = on(PaymentRequestPage).preq_id
    super
  end

  def submit
    @number = on(PaymentRequestPage).preq_id
    super
  end

  def calculate
    on(PaymentRequestPage).calculate
  end

  include ItemLinesMixin

end