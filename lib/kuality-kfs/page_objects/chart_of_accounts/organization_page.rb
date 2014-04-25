class OrganizationPage < KFSBasePage

  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationName') }
  element(:manager_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationManagerUniversal.principalName') }
  element(:resp_center_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.responsibilityCenterCode') }
  element(:physcal_campus_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationPhysicalCampusCode') }
  element(:type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.organizationTypeCode') }
  element(:default_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationDefaultAccountNumber') }
  element(:address_line_1) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationLine1Address') }
  element(:address_line_2) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationLine2Address') }
  element(:postal_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationZipCode') }
  element(:country_code) { |b| b.frm.select(name: 'document.newMaintainableObject.organizationCountryCode') }
  element(:begin_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationBeginDate') }
  element(:end_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationEndDate') }
  element(:reports_to_chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reportsToChartOfAccountsCode') }
  element(:reports_to_org_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reportsToOrganizationCode') }
  element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  element(:plant_chart) { |b| b.frm.select(name: 'document.newMaintainableObject.organizationPlantChartCode') }
  element(:plant_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationPlantAccountNumber') }
  element(:campus_plant_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.campusPlantChartCode') }
  element(:campus_plant_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.campusPlantAccountNumber') }

  value(:ro_chart_code) { |b| b.frm.span(id: 'document.newMaintainableObject.chartOfAccountsCode.div').text }
  value(:ro_org_code) { |b| b.frm.span(id: 'document.newMaintainableObject.organizationCode.div').text }
end