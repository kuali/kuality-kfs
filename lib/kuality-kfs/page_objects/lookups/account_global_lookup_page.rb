class AccountGlobalLookupPage < Lookups


  element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:account_name) { |b| b.frm.text_field(name: 'accountName') }
  element(:organization_code) { |b| b.frm.text_field(name: 'organizationCode') }
  element(:account_type_code) { |b| b.frm.select(name: 'accountTypeCode') }
  element(:sub_fund_group_code) { |b| b.frm.text_field(name: 'subFundGroupCode') }


  element(:major_reporting_category_code) { |b| b.frm.text_field(name: 'extension.majorReportingCategoryCode') }
  element(:sub_fund_program_code) { |b| b.frm.text_field(name: 'extension.programCode') }
  element(:appropriation_account_number) { |b| b.frm.text_field(name: 'extension.appropriationAccountNumber') }
  element(:fo_principal_name) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
  element(:account_manager_principal_name) { |b| b.frm.text_field(name: 'accountManagerUser.principalName') }
  element(:account_supervisor_principal_name) { |b| b.frm.text_field(name: 'accountSupervisoryUser.principalName') }

  element(:closed_yes) { |b| b.frm.radio(id: 'closedYes') }
  element(:closed_no) { |b| b.frm.radio(id: 'closedNo') }
  element(:closed_both) { |b| b.frm.radio(id: 'closedBoth') }

end