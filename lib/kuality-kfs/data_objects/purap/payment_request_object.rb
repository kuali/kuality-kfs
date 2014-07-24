class PaymentRequestObject < KFSDataObject

  include ProcessItemsAccountingLinesMixin

  attr_accessor :payment_request_id,
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
                :close_po


  def defaults
    super.merge(default_additional_charges_accounting_lines)
         .merge(default_items)
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PAYMENT_REQUEST))
                        .merge(opts))
  end

  # Fills out the Payment Request Initiation page that is the first step of creating a Payment Request
  def initiate_request
    on PaymentRequestInitiationPage do |page|
      fill_out page, :purchase_order_number,
                     :invoice_date, :invoice_number, :vendor_invoice_amount
      page.continue
    end
    #on(YesOrNoPage) {|p| p.yes if p.yes_button.present? } # Sometimes it will ask for confirmation
    on(YesOrNoPage).yes_if_possible # Sometimes it will ask for confirmation
    @payment_request_id = on(PaymentRequestPage).preq_id
  end

  # Note: You'll need to update the subcollections (e.g. Items) separately.
  def update(opts={})
    super
    on PaymentRequestPage do |page|
      edit_fields opts, page, :account_distribution_method, :payment_request_positive_approval_required,
                              :vendor_name, :vendor_number, :vendor_address_1, :vendor_address_2, :attention,
                              :vendor_city, :vendor_state, :vendor_province, :vendor_postal_code, :vendor_country,
                              :purchase_order_number, :pay_date, :bank_code,
                              :invoice_date, :invoice_number, :vendor_invoice_amount,
                              :payment_method_code,
                              :freight_extended_cost, :freight_description,
                              :misc_extended_cost, :misc_description,
                              :sh_extended_cost, :sh_description,
                              :close_po
    end
    update_options(opts)
  end
  alias_method :edit, :update

  include ItemLinesMixin

end