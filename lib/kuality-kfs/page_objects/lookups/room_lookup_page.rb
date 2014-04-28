class RoomLookupPage < Lookups

  active_radios

  element(:building_room_number) { |b| b.frm.text_field(name: 'buildingRoomNumber') }
  element(:building_room_department) { |b| b.frm.text_field(name: 'buildingRoomDepartment') }
  element(:building_room_type) { |b| b.frm.text_field(name: 'buildingRoomType') }
  element(:building_room_description) { |b| b.frm.text_field(name: 'buildingRoomDescription') }

end