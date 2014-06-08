class AssetGlobalObject < KFSDataObject

  attr_accessor :asset_description, :asset_type_code, :asset_condition, :asset_status_code, :organization_owner_account_number,
                :owner, :manufacturer, :model_number, :organization_text

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT') }
    set_options(defaults.merge(opts))
  end


end #class