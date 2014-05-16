class AssetGlobalPage < KFSBasePage

  element(:organization_owner_chat_of_accounts_code) { |b| b.select(name: 'document.newMaintainableObject.organizationOwnerChartOfAccountsCode') }

  element(:organization_owner_account_number) { |b| b.text_field(name: 'document.newMaintainableObject.organizationOwnerAccountNumber') }
  element(:owner) { |b| b.text_field(name: 'document.newMaintainableObject.agencyNumber') }
  element(:asset_status_code) { |b| b.text_field(name: 'document.newMaintainableObject.inventoryStatusCode') }

  element(:asset_condition) { |b| b.select(name: 'document.newMaintainableObject.conditionCode') }

  element(:asset_description) { |b| b.text_field(name: 'document.newMaintainableObject.capitalAssetDescription') }
  element(:asset_type_code) { |b| b.text_field(name: 'document.newMaintainableObject.capitalAssetTypeCode') }
  element(:vendor_name) { |b| b.text_field(name: 'document.newMaintainableObject.vendorName') }
  element(:manufacturer) { |b| b.text_field(name: 'document.newMaintainableObject.manufacturerName') }
  element(:model_number) { |b| b.text_field(name: 'document.newMaintainableObject.manufacturerModelNumber') }
  element(:organization_text) { |b| b.text_field(name: 'document.newMaintainableObject.organizationText') }
  element(:create_date) { |b| b.text_field(name: 'document.newMaintainableObject.createDate') }

  #LOCATION - NEW ASSET LOCATION
  element(:new_asset_campus) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.campusCode') }
  element(:new_asset_building_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.buildingCode') }
  element(:new_asset_building_room_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.buildingRoomNumber') }
  element(:new_asset_building_sub_room_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.buildingSubRoomNumber') }
  element(:off_campus_name) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusName') }
  element(:off_campus_address) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusAddress') }
  element(:off_campus_city_name) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusCityName') }
  element(:off_campus_state_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusStateCode') }
  element(:off_campus_postal_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusZipCode') }

  element(:off_campus_country) { |b| b.select(name: 'document.newMaintainableObject.add.assetSharedDetails.offCampusCountryCode') }
  element(:quantity_of_assets_to_be_created) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetSharedDetails.locationQuantity') }

  action(:add_asset_location) { |b| b.button(id: /^methodToCall\.addLine\.assetSharedDetails/).click }

  #ADD PAYMENTS - NEW ASSET PAYMENT
  element(:new_payment_chart_code) { |b| b.select(name: 'document.newMaintainableObject.add.assetPaymentDetails.chartOfAccountsCode') }
  element(:new_payment_account_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.accountNumber') }
  element(:new_payment_sub_account_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.subAccountNumber') }
  element(:new_payment_object_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.financialObjectCode') }
  element(:new_payment_sub_object) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.financialSubObjectCode') }
  element(:new_payment_project_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.projectCode') }
  element(:new_payment_organization_reference_id) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.organizationReferenceId') }
  element(:new_payment_origin) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.expenditureFinancialSystemOriginationCode') }
  element(:new_payment_document_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.expenditureFinancialDocumentNumber') }
  element(:new_payment_document_type_code) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.expenditureFinancialDocumentTypeCode') }
  element(:new_payment_purchase_order_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.purchaseOrderNumber') }
  element(:new_payment_requisition_number) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.requisitionNumber') }
  element(:new_payment_posted_date) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.expenditureFinancialDocumentPostedDate') }
  element(:new_payment_amount) { |b| b.text_field(name: 'document.newMaintainableObject.add.assetPaymentDetails.amount') }

  action(:add_new_payment) { |b| b.button(id: /^methodToCall\.addLine\.assetPaymentDetails/).click }
end