class Lookups < BasePage

  tiny_buttons
  search_results_table

  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }
  element(:first_name) { |b| b.frm.text_field(id: 'firstName') }
  element(:full_name) { |b| b.frm.text_field(id: 'fullName') }
  element(:user_name) { |b| b.frm.text_field(id: 'userName') }
  element(:create_button) { |b| b.frm.link(title: 'Create a new record') }
  action(:create_new) { |b| b.create_button.click }
  alias_method :create, :create_new

  action(:check_item) { |name, b| b.item_row(name).checkbox(name: /selectedObjId/).set }
  action(:return_selected) { |b| b.frm.button(title: 'Return selected results').click }

  action(:edit_random) { |b| b.edit_value_links[rand(b.edit_value_links.length)].click }
  element(:edit_value_links) { |b| b.results_table.links(text: 'edit') }
  action(:copy_random) { |b| b.copy_value_links[rand(b.copy_value_links.length)].click }
  element(:copy_value_links) { |b| b.results_table.links(text: 'copy') }


end