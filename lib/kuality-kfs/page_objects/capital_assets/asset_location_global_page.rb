class AssetLocationGlobalPage < KFSBasePage

  element(:asset_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.assetLocationGlobalDetails.capitalAssetNumber') }
  action(:search_asset_number) { |b| b.frm.button(title: 'Search Asset Number').click }
  action(:add_asset_number) { |b| b.frm.button(id: /^methodToCall\.addLine\.assetLocationGlobalDetails/).click }

end