class ScheduleLookupPage < Lookups

  element(:namespace) { |b| b.frm.select(name: 'namespaceCode') }
  element(:name) { |b| b.frm.text_field(name: 'name') }
  element(:group) { |b| b.frm.select(name: 'group') }
  element(:status) { |b| b.frm.select(name: 'status') }

  element(:modify_links) { |b| b.results_table.links(text: 'modify') }

end