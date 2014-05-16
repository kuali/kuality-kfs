class AssetLookupPage < Lookups

  element(:tag_number) { |b| b.frm.text_field(name: 'campusTagNumber') }
  element(:asset_number) { |b| b.frm.text_field(name: 'capitalAssetNumber') }
  element(:organization_owner_chart_of_accounts_code) { |b| b.frm.text_field(name: 'organizationOwnerChartOfAccountsCode') }
  element(:organization_owner_account_organization_code) { |b| b.frm.text_field(name: 'organizationOwnerAccount.organizationCode') }
  element(:organization_owner_account_number) { |b| b.frm.text_field(name: 'organizationOwnerAccountNumber') }
  element(:owner) { |b| b.frm.text_field(name: 'agencyNumber') }
  element(:campus) { |b| b.frm.text_field(name: 'campusCode') }
  element(:building_code) { |b| b.frm.text_field(name: 'buildingCode') }
  element(:building_room_number) { |b| b.frm.text_field(name: 'buildingRoomNumber') }
  element(:asset_type_code) { |b| b.frm.text_field(name: 'capitalAssetTypeCode') }
  element(:asset_status_code) { |b| b.frm.text_field(name: 'inventoryStatusCode') }

  element(:asset_condition) { |b| b.frm.select(name: 'conditionCode') }

  element(:vendor_name) { |b| b.frm.text_field(name: 'vendorName') }
  element(:manufacturer) { |b| b.frm.text_field(name: 'manufacturerName') }
  element(:model_number) { |b| b.frm.text_field(name: 'manufacturerModelNumber') }
  element(:serial_number) { |b| b.frm.text_field(name: 'serialNumber') }
  element(:create_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_createDate') }
  element(:create_date_to) { |b| b.frm.text_field(name: 'createDate') }
  element(:asset_representative_principal_name) { |b| b.frm.text_field(name: 'assetRepresentative.principalName') }
  element(:organization_inventory_name) { |b| b.frm.text_field(name: 'organizationInventoryName') }
  element(:asset_description) { |b| b.frm.text_field(name: 'capitalAssetDescription') }
  element(:organization_text) { |b| b.frm.text_field(name: 'assetOrganization.organizationText') }
  element(:national_stock_number) { |b| b.frm.text_field(name: 'nationalStockNumber') }
  element(:government_tag) { |b| b.frm.text_field(name: 'governmentTagNumber') }
  element(:old_tag_number) { |b| b.frm.text_field(name: 'oldTagNumber') }
  element(:organization_tag_number) { |b| b.frm.text_field(name: 'assetOrganization.organizationTagNumber') }


  element(:total_cost) { |b| b.frm.text_field(name: 'totalCostAmount') }
  element(:payment_sequence_number) { |b| b.frm.text_field(name: 'assetPayments.paymentSequenceNumber') }
  element(:payment_purchase_order_number) { |b| b.frm.text_field(name: 'assetPayments.purchaseOrderNumber') }
  element(:payment_document_number) { |b| b.frm.text_field(name: 'assetPayments.documentNumber') }
  element(:asset_location_type_code) { |b| b.frm.text_field(name: 'assetLocations.assetLocationTypeCode') }

end