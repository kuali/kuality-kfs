class BuildingLookupPage < Lookups

  active_radios

  element(:campus_code) { |b| b.frm.text_field(name: 'campusCode') }
  element(:building_code) { |b| b.frm.text_field(name: 'buildingCode') }
  element(:building_name) { |b| b.frm.text_field(name: 'buildingName') }

  # element(:active_indicator_yes) { |b| b.frm.radio(title: 'Active Indicator - Yes')}
  # element(:active_indicator_no) { |b| b.frm.radio(title: 'Active Indicator - No')}
  # element(:active_indicator_both) { |b| b.frm.radio(title: 'Active Indicator - Both')}

end