class AssetYearEndDepreciationLookupPage < Lookups

  active_radios

  element(:university_fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:run_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_runDate') }
  element(:run_date_to) { |b| b.frm.text_field(name: 'runDate') }

  #ASSET - this is after adding a new assest this
  value(:asset_number) { |l=0, b| b.frm.span(id: "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].capitalAssetNumber.div").text.strip }

  element(:asset_active_indicator) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].active") }
  value(:organization_owner_organization_code) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.organizationOwnerAccount.organizationCode.div").text.strip }
  value(:asset_description) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.capitalAssetDescription.div").text.strip }
  value(:tag_number) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.campusTagNumber.div").text.strip }

  value(:total_cost) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.totalCostAmount.div").text.strip }

  value(:accumulated_depreciation) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.accumulatedDepreciation.div").text.strip }
  value(:book_value) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.bookValue.div").text.strip }
  value(:federal_contribution) { |l=0, b| b.frm.span(id:   "document.newMaintainableObject.assetYearEndDepreciationDetails[#{l}].asset.federalContribution.div").text.strip }

  #need to test if this works with data object or if ..!! need to be handled \.\!\!
  action(:asset_delete) { |l=0, b| b.frm.button(id:   "methodToCall.deleteLine.assetYearEndDepreciationDetails.(!!.line#{l}").click }

end