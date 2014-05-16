class AssetFabricationMaintenanceDocumentObject < KFSDataObject

  attr_accessor  :organization_owner_chart_of_accounts_code, :asset_description, :asset_type_code,
                 :asset_condition, :on_campus_campus,
                 :estimated_fabrication_completion_date, :fabrication_estimated_total_amount,
                 :years_expected_to_retain_asset_once_fabrication_is_complete, :on_campus_building_code, :on_campus_building_room_number


  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT')  }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).asset_fabrication
    on AssetFabricationMaintenanceDocumentPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      #Asset Detail Information
      fill_out page, :description, :organization_owner_chart_of_accounts_code, :asset_description,
               :asset_type_code, :asset_condition, :on_campus_campus

      #Fabrication Information New
      fill_out page, :estimated_fabrication_completion_date, :fabrication_estimated_total_amount,
               :years_expected_to_retain_asset_once_fabrication_is_complete,
               :on_campus_building_code, :on_campus_building_room_number
    end
  end

end #class