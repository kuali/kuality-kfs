class AssetPage < KFSBasePage

  # ASSET DETAIL INFORMATION  - Editing
  element(:organization_owner_chart_of_accounts_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationOwnerChartOfAccountsCode') }
  element(:organization_owner_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationOwnerAccountNumber') }
  element(:owner) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
  element(:asset_status_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.inventoryStatusCode') }

  element(:asset_condition) { |b| b.frm.select(name: 'document.newMaintainableObject.conditionCode') }

  element(:asset_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.capitalAssetDescription') }
  element(:asset_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.capitalAssetTypeCode') }
  element(:vendor_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorName') }
  element(:manufacturer) { |b| b.frm.text_field(name: 'document.newMaintainableObject.manufacturerName') }
  element(:model_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.manufacturerModelNumber') }
  element(:serial_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.serialNumber') }
  element(:tag_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.campusTagNumber') }
  element(:old_tag_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.oldTagNumber') }
  element(:government_tag_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.governmentTagNumber') }
  element(:national_stock_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.nationalStockNumber') }

  element(:financial_object_sub_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectSubTypeCode') }
  element(:in_service_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.capitalAssetInServiceDate') }

  #ASSET LOCATION - Editing
  element(:on_campus_campus) { |b| b.frm.text_field(name: 'document.newMaintainableObject.campusCode') }
  element(:on_campus_building_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingCode') }
  element(:on_campus_building_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingRoomNumber') }
  element(:on_campus_building_sub_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.buildingSubRoomNumber') }

  element(:off_campus_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationContactName') }
  element(:off_campus_address) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationStreetAddress') }
  element(:off_campus_city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationCityName') }
  element(:off_campus_state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationStateCode') }
  element(:off_campus_postal_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.offCampusLocation.assetLocationZipCode') }

  element(:off_campus_country) { |b| b.frm.select(name: 'document.newMaintainableObject.offCampusLocation.assetLocationCountryCode') }

end