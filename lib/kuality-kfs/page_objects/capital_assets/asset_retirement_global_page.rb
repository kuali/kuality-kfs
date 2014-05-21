class AssetRetirementGlobalPage < KFSBasePage

  #RETIRMENT INFORMATINO - RETIREMENT REASON
  # ASSET DETAIL INFORMATION - NEW ASSET RETIRED

  element(:asset_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.assetRetirementGlobalDetails.capitalAssetNumber') }
  action(:add_asset_number) { |b| b.frm.button(id: /^methodToCall\.addLine\.assetRetirementGlobalDetails/).click }

  value(:retirement_reason_code)  { |b| b.frm.span(id: 'document.newMaintainableObject.retirementReasonCode.div').text.strip }
  value(:retirement_reason_date)  { |b| b.frm.span(id: 'document.newMaintainableObject.retirementDate.div').text.strip }

end