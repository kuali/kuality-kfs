class PurchaseOrderAmendmentObject < PurchaseOrderObject

  DOC_INFO = { label: 'Purchase Order Amendment', type_code: 'POA', transactional?: true }
  include ProcessItemsAccountingLinesMixin


  def defaults
    # We'll merge the default_items so that our class defaults (specifically @initial_item_lines) override it
    super.merge(default_items)
    .merge({
               # == Items (See ItemLinesMixin) ==
               description:    random_alphanums(40, 'AFT'),
            })
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PURCHASE_ORDER_AMENDMENT)).merge(opts))
  end

  def absorb!(target=:new)
    super
    on(PurchaseOrderAmendmentPage).expand_all
    update_line_objects_from_page!(target)
  end

  def calculate
    on(PurchaseOrderAmendmentPage).calculate
  end

  include ItemLinesMixin

end
