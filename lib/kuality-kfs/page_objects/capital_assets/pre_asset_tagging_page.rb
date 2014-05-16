class PreAssetTaggingPage < KFSBasePage

  #Edit Pre-Asset Tagging
  element(:purchase_order_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.purchaseOrderNumber') }
  element(:item_line_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.itemLineNumber') }
  element(:quantity_ordered) { |b| b.frm.text_field(name: 'document.newMaintainableObject.quantityInvoiced') }

  element(:asset_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.capitalAssetTypeCode') }

  element(:manufacturer_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.manufacturerName') }
  element(:manufacturer_model_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.manufacturerModelNumber') }
  element(:vendor_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.vendorName') }

  element(:organization_owner_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.chartOfAccountsCode') }

  element(:organization_owner_organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:organization_inventory_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationInventoryName') }
  element(:asset_representative_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.personUniversal.principalName') }
  element(:organization_text) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationText') }
  element(:purchase_order_line_item_description) { |b| b.frm.textarea(name: 'document.newMaintainableObject.assetTopsDescription') }
  element(:pretag_create_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.pretagCreateDate') }

  element(:pretag_active_indicator) { |b| b.frm.div(id: 'tab-EditPreAssetTagging-div').checkbox(name: 'document.newMaintainableObject.active') }

  #NEW DETAIL
  element(:tag_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.campusTagNumber') }
  element(:serial_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.serialNumber') }
  element(:organization_tag_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.organizationTagNumber') }
  element(:government_tag) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.governmentTagNumber') }
  element(:national_stock_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.nationalStockNumber') }

  element(:campus_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.pretagDetails.campusCode') }

  element(:building_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.buildingCode') }
  element(:building_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.buildingRoomNumber') }
  element(:building_sub_room_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.buildingSubRoomNumber') }
  element(:pretag_tag_create_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.pretagDetails.pretagTagCreateDate') }

  element(:new_pretag_active_indicator) { |b| b.frm.div(id: 'tab-EditListofPreAssetTaggingDetails-div').checkbox(name: 'document.newMaintainableObject.add.pretagDetails.active') }

  action(:add_new_detail) { |b| b.frm.div(id: 'tab-EditListofPreAssetTaggingDetails-div').button(id: /^methodToCall\.addLine\.pretagDetails/).click }

end