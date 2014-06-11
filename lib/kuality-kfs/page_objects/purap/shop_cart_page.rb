class ShopCartPage < EShopPage

  element(:shopping_cart) { |b| b.frm.form(name: 'DocumentEditForm') }
  action(:save_shopping_cart) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').click }
  action(:submit_shopping_cart) { |b| b.shopping_cart.td(id: 'CartOverlayRefId').button(text: 'Submit').click }
  value(:cart_status_message) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').parent.span(class: 'FieldOpt').text }
  element(:shopping_cart_header) { |b| b.shopping_cart.td(class: 'ForegroundContainer').table }
  element(:business_purpose_row) { |b| b.shopping_cart_header.td(text: 'Business Purpose').parent }
  element(:add_note_link) { |b| b.business_purpose_row.link(class: 'MoreInfo') }
  element(:add_note_textarea) { |b| b.business_purpose_row.textarea(name: 'Cart_NoteToAllSuppliers') }

  action(:add_note_to_cart) { |n, b| b.add_note_link.click if b.add_note_link.exists?; b.add_note_textarea.fit(n); b.save_shopping_cart }

  element(:supplier_lines) { |b| b.shopping_cart.td(class: 'ForegroundPanel').tables(class: 'Panel', text: /^(?!\s*$).+/m) }
  element(:supplier_line_for) { |s, b|
    b.shopping_cart.td(class: 'ForegroundPanel')
                   .table(class: 'Panel', text: /^(?!\s*$).+/m)
                   .link(class: 'SupplierName', text: /#{s}/m)
                   .parent.parent.parent.parent
                   .parent.parent.parent.parent
  }
  element(:line_items_table_for) { |s, b| b.supplier_line_for(s).tr(id: /^LineItemSixPack/m).parent.parent }
  element(:line_items_for) { |s, b| b.line_items_table_for(s).rows.to_a.keep_if{ |r| !r.text.empty? } }
  action(:update_product_quantity) { |s, catalog_num, b|
    b.line_items_for(s).td(class: 'LineSixPack', text: catalog_num).parent.parent.parent.text_field(name: /^Req_ProductHdrQuantity/m)
  }


end