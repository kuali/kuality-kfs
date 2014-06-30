class EShopCatalogPage < EShopPage

  # == Main content (buttons, etc.) ==
  element(:panel_right) { |b| b.frm.divs(class: 'HomeShopPanelRight') }
  element(:showcased_services_section) { |b| b.panel_right.td(text: 'Showcased Services').parent.parent } # Should be the selector div
  action(:showcased_services) { |i=0, b| b.showcased_services_section.buttons[i] }
  element(:hosted_suppliers_section) { |b| b.panel_right[b.panel_right.to_a.index { |d| d.text.match(/Hosted Suppliers/m) }] } # Should be the selector div
  value(:hosted_supplier_id) { |s, b| b.hosted_supplier(s).parent.id.gsub(/^.*_so/, '') }
  element(:hosted_suppliers_buttons) { |b| b.hosted_suppliers_section.div(id: "container-#{b.hosted_suppliers_section.id}").table.tds(class: 'sticker') }
  element(:hosted_supplier) { |s, b| b.hosted_suppliers_section.img(title: s) }
  action(:choose_hosted_supplier) { |s, b| b.hosted_supplier(s).click }
  action(:hosted_suppliers) { |i=0, b| b.hosted_suppliers_buttons[i].images.first }
  element(:punch_out_section) { |b| b.panel_right.td(text: 'Punch-out').parent.parent } # Should be the selector div
  action(:punch_out) { |i=0, b| b.punch_out_section.buttons[i] }

  element(:hosted_supplier_item_search_popup) { |s, b| b.hosted_supplier(s).parent.text_field(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so").parent }
  element(:hosted_supplier_item_search_box) { |s, b| b.hosted_supplier_item_search_popup(s).text_field(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so") }
  action(:hosted_supplier_item_search) { |s, b| b.hosted_supplier_item_search_popup(s).input(id: "HostedSearchBox_#{b.hosted_supplier_id(s)}_so_button").click }

end