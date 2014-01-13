class OrganizationLookupPage < Lookups

  account_facets
  organization_facets

  element(:reports_to_chart_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
  element(:reports_to_org_code) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }

end