class OrganizationLookupPage < Lookups

  account_facets
  organization_facets

  element(:reports_to_chart_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
  element(:reports_to_org_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }

  element(:active_indicator_yes) { |b| b.frm.radio(id: 'activeYes') }
  element(:active_indicator_no) { |b| b.frm.radio(id: 'activeNo') }
  element(:active_indicator_both) { |b| b.frm.radio(id: 'activeBoth') }

end