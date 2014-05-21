class PurchaseOrderAmendmentObject < KFSDataObject

  DOC_INFO = { label: 'Purchase Order Amendment', type_code: 'POA' }

  attr_reader :item_quantitiy, :item_catalog_number, :item_description,
              :item_unit_cost, :item_uom, :attachment_file_name, :item_object_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(40, 'AFT'),
                 item_quantity: '1000',
                 item_catalog: '10121800',
                 item_description: random_alphanums(15, 'AFT Item'),
                 item_unit_cost: '9.9',
                 item_uom: 'BX',
                 attachment_file_name:       'happy_path_reqs.png',
    }

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PURCHASE_ORDER_AMENDMENT)).merge(opts))
  end

end