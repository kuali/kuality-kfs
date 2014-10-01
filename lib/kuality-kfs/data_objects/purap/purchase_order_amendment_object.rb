class PurchaseOrderAmendmentObject < KFSDataObject

  DOC_INFO = { label: 'Purchase Order Amendment', type_code: 'POA', transactional?: true }
  include ProcessItemsAccountingLinesMixin

  attr_reader :item_quantitiy, :item_catalog_number, :item_description,
              :item_unit_cost, :item_uom, :attachment_file_name, :item_object_code

  def defaults
    # We'll merge the default_items so that our class defaults (specifically @initial_item_lines) override it
    super.merge(default_items)
    .merge({
               # == Items (See ItemLinesMixin) ==
               description:    random_alphanums(40, 'AFT'),
               initial_item_lines: [Hash.new],
               attachment_file_name:       'happy_path_reqs.png'
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
