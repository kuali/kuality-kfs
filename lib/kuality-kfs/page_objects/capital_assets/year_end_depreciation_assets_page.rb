class YearEndDepreciationAssetsPage < KFSBasePage

  #FISCAL YEAR
  element(:university_fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.universityFiscalYear') }
  element(:fiscal_year_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

  #ASSET DETAIL INFORMATION - NEW ASSET
  element(:capital_asset_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.assetYearEndDepreciationDetails.capitalAssetNumber') }
  action(:search_capital_asset_number) { |b| b.frm.button(alt: 'Search Asset Number').click }

  element(:new_asset_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.assetYearEndDepreciationDetails.active') }

  action(:add_new_asset) { |b| b.frm.button(id: /^methodToCall\.addLine\.assetYearEndDepreciationDetails/).click  }

end