class ShopCartPage < EShopPage

  element(:shopping_cart) { |b| b.frm.form(name: 'DocumentEditForm') }
  action(:save_shopping_cart) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').click }
  value(:cart_status_message) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').parent.span(class: 'FieldOpt').text }
  element(:shopping_cart_header) { |b| b.shopping_cart.td(class: 'ForegroundContainer').table }
  element(:business_purpose_row) { |b| b.shopping_cart_header.td(text: 'Business Purpose').parent }
  element(:add_note_link) { |b| b.business_purpose_row.link(class: 'MoreInfo') }
  element(:add_note_textarea) { |b| b.business_purpose_row.textarea(name: 'Cart_NoteToAllSuppliers') }

  action(:add_note_to_cart) { |n, b| b.add_note_link.click if b.add_note_link.exists?; b.add_note_textarea.fit(n); b.save_shopping_cart }

end