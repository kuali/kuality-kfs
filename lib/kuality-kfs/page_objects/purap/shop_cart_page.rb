class ShopCartPage < EShopPage

  element(:shopping_cart) { |b| b.frm.form(name: 'DocumentEditForm') }
  element(:cart_name) { |b| b.shopping_cart.text_field(name: 'Cart_CartName') }
  element(:cart_description) { |b| b.shopping_cart.text_field(name: 'Cart_Description') }

  action(:save_shopping_cart) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').click }
  action(:submit_shopping_cart) { |b| b.shopping_cart.td(id: 'CartOverlayRefId').button(text: 'Submit').click }
  value(:cart_status_message) { |b| b.shopping_cart.button(class: 'ButtonReq', value: 'Save').parent.span(class: 'FieldOpt').text }
  element(:shopping_cart_header) { |b| b.shopping_cart.td(class: 'ForegroundContainer').table }
  element(:business_purpose_row) { |b| b.shopping_cart_header.td(text: 'Business Purpose').parent }
  element(:add_note_link) { |b| b.business_purpose_row.link(class: 'MoreInfo') }
  element(:add_note_textarea) { |b| b.business_purpose_row.textarea(name: 'Cart_NoteToAllSuppliers') }

  action(:add_note_to_cart) { |n, b| b.add_note_link.click if b.add_note_link.exists?; b.add_note_textarea.fit(n); b.save_shopping_cart }

  element(:supplier_lines) { |b| b.shopping_cart.td(class: 'ForegroundPanel').tables(class: 'Panel', text: /^(?!\s*$).+/m) }
  value(:suppliers) { |b| b.shopping_cart.td(class: 'ForegroundPanel')
                                         .links(class: 'SupplierName')
                                         .to_a
                                         .collect{ |l| l.text } }
  element(:supplier_line_for) { |s, b|
    b.shopping_cart.td(class: 'ForegroundPanel')
                   .link(class: 'SupplierName', text: /#{s}/m).exist?.should
    b.shopping_cart.td(class: 'ForegroundPanel')
                   .link(class: 'SupplierName', text: /#{s}/m)
                   .parent.parent.parent.parent
                   .parent.parent.parent.parent
  }
  element(:line_items_table_for) { |s, b| b.supplier_line_for(s).tr(id: /^LineItemSixPack/m).parent.parent }
  value(:all_line_items_for) { |s, b| b.line_items_table_for(s).rows.to_a.keep_if{ |r| !r.text.empty? }[1..-1] }
  value(:supplier_subtotal_for) { |s, b| r = b.all_line_items_for(s)[-1].text.strip.split(' '); {value: r[-2], unit: r[-1]} }
  value(:line_items_for) { |s, b| b.all_line_items_for(s)[0..-2] } # This is removes the supplier subtotal line
  value(:line_item_values) { |s, l, b|
    h = Hash[ b.line_items_table_for(s).header_keys
               .keep_if{ |k| k != :'' }
               .zip( b.line_items_for(s)[l].tds.to_a
                      .keep_if{ |r| !r.text.empty? }
                      .collect{ |td| td.text } )
             ]
    h.merge({
              quantity: {
                value: b.update_product_quantity(s, h[:catalog_no]).value,
                unit: h[:quantity]
              },
              size_packaging: {
                size: h[:size_packaging].split(/\n/)[0],
                packaging: h[:size_packaging].split(/\n/)[1]
              },
              checkboxes:          b.line_items_for(s)[l].checkbox(name: /^LineCheckbox/m).checked?,
              product_description: h[:product_description].gsub(/[ ]+more info\.\.\.$/m, ''),
              ext_price: {
                value: h[:ext_price].split(' ')[0],
                unit: h[:ext_price].split(' ')[1]
              }
            })
  }
  value(:current_product_count) { |s, b| b.line_items_for(s).length }
  action(:update_product_quantity) { |s, catalog_num, b|
    b.shopping_cart.td(class: 'LineSixPack', text: /#{catalog_num}/m)
                   .parent
                   .text_field(name: /^Req_ProductHdrQuantity/m)
  }

  action(:delete_product) { |s, i, b|
    b.line_items_for(s)[i].checkbox(name: /^LineCheckbox/m).set
    b.bulk_action_dropdown.pick! 'Remove Selected Items'
    b.bulk_action_go.click
  }

  element(:bulk_action_dropdown) { |b| b.shopping_cart.span(id: 'LineActions').select }
  element(:bulk_action_go) { |b| b.shopping_cart.span(id: 'LineActions').parent.button(class: 'ButtonReq', value: 'Go') }

end