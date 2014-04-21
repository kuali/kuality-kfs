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
  element(:income_guideline_text) { |b| b.frm.textarea(name: 'document.newMaintainableObject.accountGuideline.accountIncomeGuidelineText') }
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
  value(:original_account_data) do |b|
    {
      chart_code:                b.frm.span(id: 'document.oldMaintainableObject.chartOfAccountsCode.div').text.strip,
      number:                    b.frm.span(id: 'document.oldMaintainableObject.accountNumber.div').text.strip,
      name:                      b.frm.span(id: 'document.oldMaintainableObject.accountName.div').text.strip,
      organization_code:         b.frm.span(id: 'document.oldMaintainableObject.organizationCode.div').text.strip,
      campus_code:               b.frm.span(id: 'document.oldMaintainableObject.accountPhysicalCampusCode.div').text.strip,
      effective_date:            b.frm.span(id: 'document.oldMaintainableObject.accountEffectiveDate.div').text.strip,
      postal_code:               b.frm.span(id: 'document.oldMaintainableObject.accountZipCode.div').text.strip,
      city:                      b.frm.span(id: 'document.oldMaintainableObject.accountCityName.div').text.strip,
      state:                     b.frm.span(id: 'document.oldMaintainableObject.accountStateCode.div').text.strip,
      address:                   b.frm.span(id: 'document.oldMaintainableObject.accountStreetAddress.div').text.strip,
      type_code:                 b.frm.span(id: 'document.oldMaintainableObject.accountTypeCode.div').text.strip,
      sub_fund_group_code:       b.frm.span(id: 'document.oldMaintainableObject.subFundGroupCode.div').text.strip,
      higher_ed_funct_code:      b.frm.span(id: 'document.oldMaintainableObject.financialHigherEdFunctionCd.div').text.strip,
      restricted_status_code:    b.frm.span(id: 'document.oldMaintainableObject.accountRestrictedStatusCode.div').text.strip,
      fo_principal_name:         b.frm.span(id: 'document.oldMaintainableObject.accountFiscalOfficerUser.name.div').parent.links[0].text.strip,
      supervisor_principal_name: b.frm.span(id: 'document.oldMaintainableObject.accountSupervisoryUser.name.div').parent.links[0].text.strip,
      manager_principal_name:    b.frm.span(id: 'document.oldMaintainableObject.accountManagerUser.name.div').parent.links[0].text.strip,
      budget_record_level_code:  b.frm.span(id: 'document.oldMaintainableObject.budgetRecordingLevelCode.div').text.strip,
      sufficient_funds_code:     b.frm.span(id: 'document.oldMaintainableObject.accountSufficientFundsCode.div').text.strip,
      expense_guideline_text:    b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountExpenseGuidelineText.div').text.strip,
      income_guideline_text:     b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountIncomeGuidelineText.div').text.strip,
      purpose_text:              b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountPurposeText.div').text.strip,
      income_stream_financial_cost_code: b.frm.span(id: 'document.oldMaintainableObject.incomeStreamFinancialCoaCode.div').text.strip,
      income_stream_account_number:      b.frm.span(id: 'document.oldMaintainableObject.incomeStreamAccountNumber.div').text.strip,
      account_expiration_date:           b.frm.span(id: 'document.oldMaintainableObject.accountExpirationDate.div').text.strip,
      # TODO: Make the next few lines grab every line of the ICRA data once we create a collection for ICRA data
      indirect_cost_recovery_chart_of_accounts_code: b.frm.span(id: 'document.oldMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryFinCoaCode.div').text.strip,
      indirect_cost_recovery_account_number:         b.frm.span(id: 'document.oldMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryAccountNumber.div').text.strip,
      indirect_cost_recovery_account_line_percent:   b.frm.span(id: 'document.oldMaintainableObject.indirectCostRecoveryAccounts[0].accountLinePercent.div').text.strip,
      indirect_cost_recovery_active_indicator:       yesno2setclear(b.frm.span(id: 'document.oldMaintainableObject.indirectCostRecoveryAccounts[0].active.div').text.strip)
    }.merge(b.respond_to?(:original_account_extended_data) ? b.original_account_extended_data : Hash.new)
  end
  value(:new_account_data) do |b|
    {
        chart_code:                b.chart_code.value,
        number:                    b.number.value,
        name:                      b.name.value,
        organization_code:         b.organization_code.value,
        campus_code:               b.campus_code.selected_options.first.text,
        effective_date:            b.effective_date.value,
        postal_code:               b.postal_code.value,
        city:                      b.city.value,
        state:                     b.state.value,
        address:                   b.address.value,
        type_code:                 b.type_code.selected_options.first.text,
        sub_fund_group_code:       b.sub_fund_group_code.value,
        higher_ed_funct_code:      b.higher_ed_funct_code.value,
        restricted_status_code:    b.restricted_status_code.selected_options.first.text,
        fo_principal_name:         b.fo_principal_name.value,
        supervisor_principal_name: b.supervisor_principal_name.value,
        manager_principal_name:    b.manager_principal_name.value,
        budget_record_level_code:  b.budget_record_level_code.selected_options.first.text,
        sufficient_funds_code:     b.sufficient_funds_code.selected_options.first.text,
        expense_guideline_text:    b.expense_guideline_text.value,
        income_guideline_text:     b.income_guideline_text.value,
        purpose_text:              b.purpose_text.value,
        income_stream_financial_cost_code: b.income_stream_financial_cost_code.selected_options.first.text,
        income_stream_account_number:      b.income_stream_account_number.value,
        account_expiration_date:           b.account_expiration_date.value,
        # TODO: Make the next few lines grab every line of the ICRA data once we create a collection for ICRA data
        indirect_cost_recovery_chart_of_accounts_code: b.frm.select(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryFinCoaCode').selected_options.first.text,
        indirect_cost_recovery_account_number:         b.frm.text_field(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].indirectCostRecoveryAccountNumber').value,
        indirect_cost_recovery_account_line_percent:   b.frm.text_field(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].accountLinePercent').value,
        indirect_cost_recovery_active_indicator:       yesno2setclear(b.frm.checkbox(name: 'document.newMaintainableObject.indirectCostRecoveryAccounts[0].active').value)
    }.merge(b.respond_to?(:new_account_extended_data) ? b.new_account_extended_data : Hash.new)
  end

  value(:account_maintenance_errors) { |b| b.frm.div(id: 'tab-AccountMaintenance-div').div(class: 'left-errmsg-tab').div.divs.collect{ |div| div.text }  }

  element(:error_icon) { |b| b.frm.image(alt: 'error') }

end