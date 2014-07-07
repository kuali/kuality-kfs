class PaymentRequestObject < KFSDataObject


  attr_accessor :payment_request_positive_approval_required

  def defaults
    # We'll merge the default_items so that our class defaults (specifically @initial_item_lines) override it
    super.merge(default_items)
         # .merge({
         #
         #        })
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PAYMENT_REQUEST))
                        .merge(opts))
  end

  include ItemLinesMixin

end