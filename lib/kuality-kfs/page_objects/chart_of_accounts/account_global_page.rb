class AccountGlobalPage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:new_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.accountGlobalDetails.chartOfAccountsCode') }
  element(:new_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountGlobalDetails.accountNumber') }
  action(:add_account_detail) { |b| b.frm.button(name: /^methodToCall.addLine.accountGlobalDetails/).click }

  element(:fo_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountFiscalOfficerUser.principalName') }
  element(:supervisor_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountSupervisoryUser.principalName') }
  element(:manager_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountManagerUser.principalName') }
  element(:org_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:sub_fnd_group_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subFundGroupCode') }
  element(:acct_expire_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountExpirationDate') }
  element(:postal_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountZipCode') }
  element(:city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountCityName') }
  element(:state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountStateCode') }
  element(:address) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountStreetAddress') }
  element(:continuation_coa_code) { |b| b.frm.select(name: 'document.newMaintainableObject.continuationFinChrtOfAcctCd') }
  element(:continuation_acct_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.continuationAccountNumber') }
  element(:income_stream_financial_cost_code) { |b| b.frm.select(name: 'document.newMaintainableObject.incomeStreamFinancialCoaCode') }
  element(:income_stream_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.incomeStreamAccountNumber') }
  element(:cfda_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountCfdaNumber') }
  element(:higher_ed_funct_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialHigherEdFunctionCd') }
  element(:sufficient_funds_code) { |b| b.frm.select(name: 'document.newMaintainableObject.accountSufficientFundsCode') }
  element(:trans_processing_sufficient_funds_code) { |b| b.frm.select(name: 'document.newMaintainableObject.pendingAcctSufficientFundsIndicator') }
  element(:labor_benefit_rate_category_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.laborBenefitRateCategoryCode') }




end