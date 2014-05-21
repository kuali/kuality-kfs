class AssetFabricationMaintenanceDocumentPage < KFSBasePage

  #ASSET DETAIL INFORMATION
  element(:organization_owner_chart_of_accounts_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationOwnerChartOfAccountsCode') }
  element(:organization_owner_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationOwnerAccountNumber') }
  element(:owner) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }

  element(:asset_condition) { |b| b.frm.select(name: 'document.newMaintainableObject.conditionCode') }

  element(:asset_description) { |b| b.frm.textarea(name: 'document.newMaintainableObject.capitalAssetDescription') }
  element(:asset_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.capitalAssetTypeCode') }

  #NEW - ON CAMPUS
  element(:on_campus_campus) { |b| b.frm.text_field(name: 'document.newMaintainableObject.campusCode') }
  element(:on_campus_building_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingCode') }
  element(:on_campus_building_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingRoomNumber') }
  element(:on_campus_building_sub_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingSubRoomNumber') }

  #NEW - OFF CAMPUS
  element(:off_campus_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationContactName') }
  element(:off_campus_address) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationStreetAddress') }
  element(:off_campus_city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationCityName') }
  element(:off_campus_state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationStateCode') }
  element(:off_campus_postal_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationZipCode') }

  element(:off_campus_country) { |b| b.frm.select(name: 'document.newMaintainableObject.offCampusLocation.assetLocationCountryCode') }

  #ORGANIZATION INFORMATION - NEW
  element(:organization_inventory_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationInventoryName') }
  element(:asset_representative_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.assetRepresentative.principalName') }
  element(:asset_representative_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.assetRepresentative.name') }
  element(:organization_text) { |b| b.frm.text_field(name: 'document.newMaintainableObject.assetOrganization.organizationText') }
  element(:organization_asset_type_identifier) { |b| b.frm.text_field(name: 'document.newMaintainableObject.assetOrganization.organizationAssetTypeIdentifier') }

  #FABRICATION INFORMATION
  element(:estimated_fabrication_completion_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.estimatedFabricationCompletionDate') }
  element(:fabrication_estimated_total_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.fabricationEstimatedTotalAmount') }
  element(:years_expected_to_retain_asset_once_fabrication_is_complete) { |b| b.frm.text_field(name: 'document.newMaintainableObject.fabricationEstimatedRetentionYears') }
  alias_method :fabrication_is_complete, :years_expected_to_retain_asset_once_fabrication_is_complete

end