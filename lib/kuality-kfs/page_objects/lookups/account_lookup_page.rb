class AccountLookupPage < Lookups

  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:name) { |b| b.frm.text_field(name: 'accountName') }
  element(:org_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:type_code) { |b| b.frm.select(name: 'accountTypeCode') }
  element(:sub_fnd_group_code) { |b| b.frm.text_field(name: 'subFundGroupCode') }
  element(:fo_principal_name) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
  element(:closed) { |b| b.frm.text_field(name: 'closed') }

  action(:select_all_from_this_page) { |b| b.frm.img(title: 'Select all rows from this page').when_present.click }
  action(:select_all_from_all_pages) { |b| b.frm.img(title: 'Select all rows from all pages').click }
  action(:deselect_all_from_all_pages) { |b| b.frm.img(title: 'Unselect all rows from all pages').click }
  action(:deselect_all_from_this_page) { |b| b.frm.img(title: 'Deselect all rows from this page').click }

end