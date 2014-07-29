class PurchaseOrderObject < RequisitionObject

  DOC_INFO = { label: 'Purchase Order', type_code: 'PO' }

  attr_accessor :purchase_order_number

  def defaults
    super.merge(
    {
      initial_item_lines: [{
                            quantity:             '1000',
                            uom:                  'BX', # TODO: Get this from the service
                            catalog_number:       '10121800',
                            description:          random_alphanums(15, 'AFT Item'),
                            unit_cost:            '9.9'
                           }]
    })
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PURCHASE_ORDER)).merge(opts))
  end

  # TODO: PurchaseOrderObject#create
  # TODO: PurchaseOrderObject#edit
  # TODO: PurchaseOrderObject#absorb!

  def view_via(how='doc search')
    if how == 'e-SHOP'
      on EShopPage do |page|
        page.clear_announcement if page.announcements_block.present?
        page.goto_doc_search
      end
      on EShopAdvancedDocSearchPage do |page|
        page.search_doc_type.fit 'Purchase Orders'
        page.po_id.fit           @purchase_order_number
        page.date_range.fit      'Today'
        sleep 2
        page.go_button.click
      end
    elsif 'doc search'
      view
    else
      raise ArgumentError, "No way to view the Purchase Order known named '#{how}'!"
    end
  end

  include ItemLinesMixin

end