class BuildingLookupPage < Lookups

  active_radios

  element(:campus_code) { |b| b.frm.text_field(name: 'campusCode') }
  element(:building_code) { |b| b.frm.text_field(name: 'buildingCode') }
  element(:building_name) { |b| b.frm.text_field(name: 'buildingName') }

end