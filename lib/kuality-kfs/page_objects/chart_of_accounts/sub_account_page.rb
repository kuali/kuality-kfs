class SubAccountPage < KFSBasePage

  #Edit Sub-Account Code
  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subAccountNumber') }
  element(:name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subAccountName') }
  element(:type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.subAccountTypeCode') }
  element(:active_indicator) { |b| b.checkbox(name: 'document.newMaintainableObject.active') }
  element(:sub_account_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.a21SubAccount.subAccountTypeCode') }

  #Edit Financial Reporting Code
  element(:financial_reporting_chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialReportChartCode') }
  action(:search_financial_reporting_chart_code) { |b| b.frm.button(alt: 'Search Financial Reporting Chart Code').click }
  element(:financial_reporting_org_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.finReportOrganizationCode') }
  action(:search_financial_reporting_org_code) { |b| b.frm.button(alt: 'Search Financial Reporting Org Code').click }
  element(:financial_reporting_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialReportingCode') }
  action(:search_financial_reporting_code) { |b| b.frm.button(alt: 'Search Financial Reporting Code').click }

  #Edit CG Cost Sharing
  element(:cost_sharing_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.a21SubAccount.costShareChartOfAccountCode') }
  element(:cost_sharing_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.costShareSourceAccountNumber') }
  element(:cost_sharing_sub_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.costShareSourceSubAccountNumber') }

  element(:search_cost_sharing_chart_of_accounts_code) { |b| b.button(alt: 'Search Cost Sharing Chart of Accounts Code') }
  element(:search_cost_sharing_account_number) { |b| b.button(alt: 'Search Cost Sharing Account Number') }
  element(:search_cost_sharing_sub_account_number) { |b| b.button(alt: 'Search Cost Sharing Sub-Account Number') }

  #Edit CG ICR
  element(:icr_identifier) { |b| b.frm.text_field(name: 'document.newMaintainableObject.a21SubAccount.financialIcrSeriesIdentifier') }

  #Ad Hoc Recipients
  element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  action(:ad_hoc_person_add) { |b| b.frm.button(name: 'methodToCall.insertAdHocRoutePerson').click }

end