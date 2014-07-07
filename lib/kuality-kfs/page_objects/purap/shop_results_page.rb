class ShopResultsPage < EShopPage

 element(:shop_results_table) { |b| b.frm.div(class: 'PageContent').form(name: 'ProductListForm') }
 element(:shop_results_controls) { |b| b.shop_results_table.div(class: 'PaginationHdrTop').tr }
 element(:shop_results_rows) { |b| b.shop_results_table.table.trs(onmouseout: 'Dom.addClass(this, \'UnhighlightedRow\');') }
 element(:shop_results_rows_with_price) { |p, b| b.shop_results_rows.to_a.keep_if{ |tr| tr.div(class: 'ResultsPrice', text: /#{p}/m).exists? } }
 action(:add_random_item_with_price) { |p, b| b.shop_results_rows_with_price(p).sample.button(value: 'Add to Cart').click }
 action(:add_item_with_price) { |p, b| b.shop_results_rows_with_price(p).first.button(value: 'Add to Cart').click }
 action(:add_item_with_text_and_price) { |t, p, b| b.shop_results_rows_with_price(p).to_a.keep_if{ |tr| tr.text.include?(t) }.first.button(value: 'Add to Cart').click }
 action(:add_item) { |i=0, b| b.shop_results_rows[i].button(value: 'Add to Cart').click }
 element(:item_quantity) { |i=0, b| b.shop_results_rows[i].text_field(id: /^SearchResults_Quantity/m) }

end