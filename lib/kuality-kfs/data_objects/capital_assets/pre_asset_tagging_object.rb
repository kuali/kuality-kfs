class PreAssetTaggingObject < KFSDataObject

  attr_accessor :purchase_order_number, :item_line_number, :quantity_ordered, :manufacturer_name,
                :vendor_name, :organization_owner_organization_code, :purchase_order_line_item_description,
                :asset_type_code, :organization_owner_chart_of_accounts_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT') }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).pre_asset_tagging
    on(PreAssetTaggingLookupPage).create_new

    on PreAssetTaggingPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :purchase_order_number, :item_line_number, :quantity_ordered, :manufacturer_name,
               :vendor_name, :organization_owner_organization_code, :purchase_order_line_item_description,
               :asset_type_code, :organization_owner_chart_of_accounts_code

     #NOTE: Edit List of Pre-Asset Tagging Details - New Detail: is not a required section

    end
  end

end #class

