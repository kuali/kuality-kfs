class OrganizationLookupPage < Lookups

  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:org_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:name) { |b| b.frm.text_field(name: 'organizationName') }
  element(:resp_center_code) { |b| b.frm.text_field(name: 'subFundGroupCode') }
  element(:type_code) { |b| b.frm.select(name: 'accountTypeCode') }
  element(:reports_to_chart_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
  element(:reports_to_org_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }

  element(:active_indicator_yes) { |b| b.frm.radio(id: 'activeYes') }
  element(:active_indicator_no) { |b| b.frm.radio(id: 'activeNo') }
  element(:active_indicator_both) { |b| b.frm.radio(id: 'activeBoth') }

end