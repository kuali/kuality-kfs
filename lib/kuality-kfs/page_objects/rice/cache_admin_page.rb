class CacheAdminPage < BasePage
  action(:flush) { |b| b.frm.button(id: 'u10').click }
  element(:cache_boxes) { |b| b.frm.inses(class: 'jstree-checkbox') }
end