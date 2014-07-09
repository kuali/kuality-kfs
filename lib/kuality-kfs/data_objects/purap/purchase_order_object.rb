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

  def view(in_eshop=false)
    if in_eshop
      on(EShopPage).goto_doc_search
      on EShopAdvancedDocSearchPage do |page|
        page.search_doc_type.fit 'Purchase Orders'
        page.po_id.fit      @purchase_order_number
        page.date_range.fit 'Today'
        sleep 2
        page.go_button.click
      end
    else
      visit(MainPage).doc_search
      on DocumentSearch do |search|
        search.document_type.fit ''
        search.document_id.fit   @document_id
        search.search
        search.wait_for_search_results
        search.open_doc @document_id
      end
    end
  end

end #class