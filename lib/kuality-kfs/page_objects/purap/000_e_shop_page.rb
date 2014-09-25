class EShopPage < KFSBasePage

  element(:notification_bar) { |b| b.frm.div(class: 'NotificationBar').ul(class: 'NotificationContent') }
  action(:goto_cart) { |b| b.notification_bar.link(id: 'Phoenix_Nav_Cart_Invoker').click; b.notification_bar.div(id: 'Phoenix_Nav_Cart').link(id: 'PHX_NAV_CartPreviewViewCart_cart').click }
  action(:goto_home) { |b| b.frm.link(id: 'PHX_NAV_HomeChooser').click }
  value(:cart_total) { |b| b.notification_bar.link(id: 'Phoenix_Nav_Cart_Invoker').span(id: 'cartTotal').text }
  value(:cart_total_value) { |b| b.cart_total.split(' ')[0] }
  value(:cart_total_unit) { |b| b.cart_total.split(' ')[1] }

  element(:order_doc_element) { |b| b.frm.link(id: 'PHX_NAV_OrdersAndDocuments_Invoker' ) }
  action(:order_doc) { |b| b.frm.link(id: 'PHX_NAV_OrdersAndDocuments_Invoker' ).click }
  action(:po_doc_search) { |b| b.frm.link(id: 'PHX_NAV_DocumentSearchSearch' ).when_present.click }
  action(:goto_doc_search) { |b| b.order_doc; b.po_doc_search; }

  element(:search_results) { |b| b.frm.table(class: 'SearchResults') }

  element(:announcements_block) { |b| b.frm.td(text: /Announcements/m) }
  action(:clear_announcement) { |b| b.announcements_block.parent.parent.button(value: 'Continue').click }

  element(:continue_to_eshop) { |b| b.continue_to_eshop_button.click }
  element(:continue_to_eshop_button) { |b| b.frm.button(value: 'Continue') }

  action(:eshop_home) { |b| b.frm.link(id: 'PHX_NAV_HomeChooser').click }
end