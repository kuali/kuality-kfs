class AccountPage < KFSBasePage

  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountNumber') }
  element(:name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountName') }
  element(:organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.organizationCode') }
  element(:campus_code) { |b| b.frm.select(name: 'document.newMaintainableObject.accountPhysicalCampusCode') }
  element(:effective_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountEffectiveDate') }
  element(:postal_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountZipCode') }
  element(:city) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountCityName') }
  element(:state) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountStateCode') }
  element(:address) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountStreetAddress') }
  element(:type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.accountTypeCode') }
  element(:sub_fund_group_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.subFundGroupCode') }
  element(:higher_ed_funct_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialHigherEdFunctionCd') }
  element(:restricted_status_code) { |b| b.frm.select(name: 'document.newMaintainableObject.accountRestrictedStatusCode') }
  element(:fo_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountFiscalOfficerUser.principalName') }
  element(:supervisor_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountSupervisoryUser.principalName') }
  element(:manager_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountManagerUser.principalName') }
  element(:budget_record_level_code) { |b| b.frm.select(name: 'document.newMaintainableObject.budgetRecordingLevelCode') }
  element(:sufficient_funds_code) { |b| b.frm.select(name: 'document.newMaintainableObject.accountSufficientFundsCode') }
  element(:expense_guideline_text) { |b| b.frm.textarea(name: 'document.newMaintainableObject.accountGuideline.accountExpenseGuidelineText') }
  element(:income_guideline_txt) { |b| b.frm.textarea(name: 'document.newMaintainableObject.accountGuideline.accountIncomeGuidelineText') }
  element(:purpose_text) { |b| b.frm.textarea(name: 'document.newMaintainableObject.accountGuideline.accountPurposeText') }
  element(:closed) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.closed') }
  element(:continuation_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.continuationFinChrtOfAcctCd') }
  element(:continuation_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.continuationAccountNumber') }
  element(:account_expiration_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountExpirationDate') }

  element(:income_stream_financial_cost_code) { |b| b.frm.select(name: 'document.newMaintainableObject.incomeStreamFinancialCoaCode') }
  element(:income_stream_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.incomeStreamAccountNumber') }

  element(:indirect_cost_recovery_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryFinCoaCode') }
  element(:indirect_cost_recovery_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryAccountNumber') }
  element(:indirect_cost_recovery_account_line_percent) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.accountLinePercent') }
  element(:indirect_cost_recovery_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.active') }

  value(:original_chart_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.chartOfAccountsCode.div').text.strip }
  value(:original_account_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountNumber.div').text.strip }

  value(:account_maintenance_errors) { |b| b.frm.div(id: 'tab-AccountMaintenance-div').div(class: 'left-errmsg-tab').div.divs.collect{ |div| div.text }  }

  element(:error_icon) { |b| b.frm.image(alt: 'error') }

end