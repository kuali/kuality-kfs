class CapitalAssetsTab < PageFactory

  include Utilities
  include GlobalConfig

  action(:use_new_tab) { |b| b.windows.last.use }
  action(:close_parents) { |b| b.windows[0..-2].each{ |w| w.close} }

  # CA accounting lines
  action(:generate_accounting_lines_for_capitalization) { |b| b.frm.button(name: "methodToCall.generateAccountingLinesForCapitalization").click }
  element(:accounting_lines_for_capitalization_select) { |i=0, b| b.frm.checkbox(id: "document.capitalAccountingLines[#{i}].selectLine") }
  element(:distribution_method) { |b| b.frm.select(id: "capitalAccountingLine.distributionCode") }
  action(:modify_asset) { |b| b.frm.button(name: 'methodToCall.modifyAsset').click; b.use_new_tab; b.close_parents }
  action(:create_asset) { |b| b.frm.button(name: 'methodToCall.createAsset').click; b.use_new_tab; b.close_parents }
  #action(:redistribute_capital_asset_amount) { |b| b.frm.button(name: 'methodToCall.redistributeModifyCapitalAssetAmount').click }

  # create CA
  element(:line_amount) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetLineAmount") }
  action(:redistribute_amount) { |b| b.frm.button(name: 'methodToCall.redistributeCreateCapitalAssetAmount').click }
  action(:insert_tag) { |i=0, b| b.frm.button(name: /methodToCall.insertCapitalAssetInfo.line#{i}.Anchor/).click; b.use_new_tab; b.close_parents }
  element(:qty) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetQuantity") }
  element(:type) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetTypeCode") }
  element(:manufacturer) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetManufacturerName") }
  element(:description) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetDescription") }

  element(:tag_number) { |i=0, j=0,  b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].capitalAssetTagNumber") }
  element(:campus) { |i=0, j=0,  b| b.frm.select(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].campusCode") }
  element(:building) { |i=0, j=0,  b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].buildingCode") }
  element(:room) { |i=0, j=0,  b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].buildingRoomNumber") }
  #value(:remain_asset_amount) { |b| b.frm.table(summary: 'Capital Asset Information')[0][0].table[1][1].text.split(':')[1] }
  element(:remain_asset_amount) { |b| b.frm.td(class: 'tab-subhead', text: /System Control Remainder Amount:/).text.split(':')[1] }
  value(:asset_account_number) { |b| b.frm.table(summary: 'Asset for Accounting Lines')[1][4].text.strip }
  action(:vendor_search) { |b| b.frm.button(name: /methodToCall.performLookup.\(!!org.kuali.kfs.vnd.businessobject.VendorDetail!!\)/m).click }
  action(:delete_asset) { |i=0, b| b.frm.button(id: "methodToCall.deleteCapitalAssetInfo.line#{i}.Anchor").click }
  value(:asset_tables) { |b| b.frm.tables(summary: "Asset for Accounting Lines") }
  value(:current_asset_count) { |b| b.asset_tables.length - 1 }
  value(:old_qty) { |i=0, b| b.frm.hidden(name: "document.capitalAssetInformation[#{i}].capitalAssetQuantity") }
  value(:old_type) { |i=0, b| b.frm.hidden(name: "document.capitalAssetInformation[#{i}].capitalAssetTypeCode") }
  value(:old_manufacturer) { |i=0, b| b.frm.hidden(name: "document.capitalAssetInformation[#{i}].capitalAssetManufacturerName") }
  # TODO : not sure why this is still editable when doc is FINAL
  element(:old_line_amount) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetLineAmount") }
  value(:old_description) { |i=0, b| b.asset_tables(i+1)[2][1].text.strip } # no hidden value or span

  action(:delete_asset_location) { |i=0, b| b.frm.button(id: "methodToCall.deleteCapitalAssetInfoDetailLine.line#{i}.Anchor").click }
  value(:current_asset_location_count) { |i=0, b| b.b.asset_tables(i+1).table(summary: "Capital Asset Information Details").rows.length - 1 }
  value(:old_tag_number) { |i=0, j=0,  b| b.frm.hidden(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].capitalAssetTagNumber") }
  value(:old_campus) { |i=0, j=0,  b| b.frm.hidden(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].campusCode") }
  value(:old_building) { |i=0, j=0,  b| b.frm.hidden(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].buildingCode") }
  value(:old_room) { |i=0, j=0,  b| b.frm.hidden(id: "document.capitalAssetInformation[#{i}].capitalAssetInformationDetails[#{j}].buildingRoomNumber") }
  value(:asset_detail_tables) { |b| b.frm.tables(summary: "Capital Asset Information Details") }


  # modify CA
  element(:number) { |i=0, b| b.frm.text_field(id: "document.capitalAssetInformation[#{i}].capitalAssetNumber") }
  action(:redistribute_modify_amount) { |b| b.frm.button(name: 'methodToCall.redistributeModifyCapitalAssetAmount').click }


end



