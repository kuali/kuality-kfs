class AssetAcquisitinoTypePage < Lookups

  active_radios

  element(:acquisition_type_code) { |b| b.frm.text_field(name: 'acquisitionTypeCode') }
  element(:acquisition_type_name) { |b| b.frm.text_field(name: 'acquisitionTypeName') }
  element(:income_asset_object_code) { |b| b.frm.text_field(name: 'incomeAssetObjectCode') }

end