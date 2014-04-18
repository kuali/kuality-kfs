class RequisitionObject < KFSDataObject

  attr_reader :description, :item_account_number, :item_object_code, :item_catalog_number, :item_description, :item_unit_cost, :item_quantity, :item_uom, :attachment_file_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(40, 'AFT'),
        item_quantity: '1000',
        item_catalog: '10121800',
        item_description: random_alphanums(15, 'AFT Item'),
        item_unit_cost: '9.9',
        item_uom: 'BX',
        attachment_file_name:       'happy_path_reqs.png'
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
      fill_out page, :item_quantity, :item_catalog_number, :item_commodity_code, :item_description, :item_unit_cost, :item_restricted, :item_assigned, :item_uom
      page.item_add
      fill_out page, :description

      #Add Accounting line
      fill_out page, :item_account_number, :item_object_code, :item_percent
      page.item_add_account_line

      page.balance_inquiry_button.wait_until_present
      page.calculate

      @requisition_id = page.requisition_id

      #FOR DEBUGGING
      puts 'is the req number'
      puts @requisition_id
      puts 'is the Doc ID number'
      puts @document_id

      #Requisition number is created only after a successful submit
    end
  end


  def edit opts={}
    visit(MainPage).requisitions
    on DocumentSearch do |page|
      page.document_id
    end

    on RequisitionPage do |page|
       #edit something
    end
    update_options(opts)
  end

  def add_vendor_to_req(vendor_num)
    on RequisitionPage do |page|
      page.suggested_vendor_search

      on VendorLookupPage do |page|
        page.vendor_number.wait_until_present
        page.vendor_number.fit vendor_num
        page.search
        page.return_value(vendor_num)
      end
    end
  end


end #class