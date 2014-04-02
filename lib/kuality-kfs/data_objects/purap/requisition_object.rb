class RequisitionObject < KFSDataObject

  #DOC_INFO = { label: 'Requisition', type_code: 'REQ' }

  attr_reader :description, :item_quantitiy, :item_catalog_number, :item_description, :unit_cost, :item_uom

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(40, 'AFT'),
        item_quantity: '1000',
        item_catalog: '10121800',
        item_description: random_alphanums(15, 'AFT Item'),
        unit_cost: '9.9',
        item_uom: 'BX'
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).requisition
    on RequisitionPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      #Add Item
      fill_out page, :item_quantity, :item_catalog_number, :item_commodity_code, :item_description, :unit_cost, :item_restricted, :item_assigned, :item_uom
      page.item_add
      fill_out page, :description

      #Add Accounting line
      fill_out page, :item_account_number, :item_object_code, :item_percent
      page.item_add_account_line

      #wait? for balance Perform Balance Inquiry for Source Accounting Line 1
      page.balance_inquiry_button.wait_until_present
      page.calculate


    end

  end
  #
  #And I create the Requisition document with:
  #| positive approval | :clear   |
  #| vendor            | 4471-0   |
  #| e-shop flags      | :clear   |
  #
  #| item number       | 9.9      |
  #
  #| item quanity      | 1000     |
  #
  #| item name         | Dog Food |
  #|
  #item account      | 10121800 |
  #
  #
  #| account number    | 1093603  |
  #| object code       | 6540     |
  #| percent           | 100      |
  #| button            | calculate|


end #class