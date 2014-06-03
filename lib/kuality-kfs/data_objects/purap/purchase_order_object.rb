class PurchaseOrderObject < KFSDataObject

  DOC_INFO = { label: 'Purchase Order', type_code: 'PO' }

  attr_reader :item_quantitiy, :item_catalog_number, :item_description,
              :item_unit_cost, :item_uom, :attachment_file_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(40, 'AFT'),
        item_quantity: '1000',
        item_catalog: '10121800',
        item_description: random_alphanums(15, 'AFT Item'),
        item_unit_cost: '9.9',
        item_uom: 'BX',
        attachment_file_name:       'happy_path_reqs.png'
    }

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PURCHASE_ORDER)).merge(opts))
  end

  #def build
  #  visit(MainPage).purchase_orders
  #  on DocumentSearch do |page|
  #    page.requisition_number.fit :requisition_id
  #    page.search
  #    #click link where po number exists
  #    page.select_doc_id_with_po_number('290716')
  #
  #  end
  #
  #
  #  on PurchaseOrderPage do |page|
  #    page.expand_all
  #    page.description.focus
  #    page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
  #
  #
  #    @requisition_id = page.requisition_id
  #    #FOR DEBUGGING
  #    puts 'is the req number'
  #    puts @requisition_id
  #    puts 'was the req number'
  #    puts @document_id
  #
  #  end
  #end

end #class