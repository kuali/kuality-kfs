class EShopPage < KFSBasePage

  element(:notification_bar) { |b| b.frm.div(class: 'NotificationBar').ul(class: 'NotificationContent') }
  action(:goto_cart) { |b| b.notification_bar.link(id: 'Phoenix_Nav_Cart_Invoker').click; b.notification_bar.div(id: 'Phoenix_Nav_Cart').link(id: 'PHX_NAV_CartPreviewViewCart_cart').click }
  value(:cart_total) { |b| b.notification_bar.link(id: 'Phoenix_Nav_Cart_Invoker').span(id: 'cartTotal').text }
  value(:cart_total_value) { |b| b.cart_total.split(' ')[0] }
  value(:cart_total_unit) { |b| b.cart_total.split(' ')[1] }

end