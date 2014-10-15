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

  element(:contract_control_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.contractControlFinCoaCode') }
  element(:contract_control_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.contractControlAccountNumber') }
  element(:account_icr_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.acctIndirectCostRcvyTypeCd') }
  element(:indirect_cost_rate) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialIcrSeriesIdentifier') }
  element(:cfda_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.accountCfdaNumber') }
  element(:cg_account_responsibility_id) { |b| b.frm.select(name: 'document.newMaintainableObject.contractsAndGrantsAccountResponsibilityId') }

  element(:income_stream_financial_cost_code) { |b| b.frm.select(name: 'document.newMaintainableObject.incomeStreamFinancialCoaCode') }
  element(:income_stream_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.incomeStreamAccountNumber') }

  #Contracts and Grants tab
  element(:indirect_cost_recovery_chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryFinCoaCode') }
  element(:indirect_cost_recovery_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryAccountNumber') }
  element(:indirect_cost_recovery_account_line_percent) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.accountLinePercent') }
  element(:indirect_cost_recovery_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.active') }

  # New
  value(:chart_code_new) { |b| b.chart_code.exists? ? b.chart_code.value : b.chart_code_readonly }
  value(:number_new) { |b| b.number.exists? ? b.number.value : b.number_readonly }
  value(:name_new) { |b| b.name.exists? ? b.name.value : b.name_readonly }
  value(:organization_code_new) { |b| b.organization_code.exists? ? b.organization_code.value : b.organization_code_readonly }
  value(:campus_code_new) { |b| b.campus_code.exists? ? b.campus_code.selected_options.first.text : b.campus_code_readonly }
  value(:effective_date_new) { |b| b.effective_date.exists? ? b.effective_date.value : b.effective_date_readonly }
  value(:postal_code_new) { |b| b.postal_code.exists? ? b.postal_code.value : b.postal_code_readonly }
  value(:city_new) { |b| b.city.exists? ? b.city.value : b.city_readonly }
  value(:state_new) { |b| b.state.exists? ? b.state.value : b.state_readonly }
  value(:address_new) { |b| b.address.exists? ? b.address.value : b.address_readonly }
  value(:type_code_new) { |b| b.type_code.exists? ? b.type_code.selected_options.first.text : b.type_code_readonly }
  value(:sub_fund_group_code_new) { |b| b.sub_fund_group_code.exists? ? b.sub_fund_group_code.value : b.sub_fund_group_code_readonly }
  value(:higher_ed_funct_code_new) { |b| b.higher_ed_funct_code.exists? ? b.higher_ed_funct_code.value : b.higher_ed_funct_code_readonly }
  value(:restricted_status_code_new) { |b| b.restricted_status_code.exists? ? b.restricted_status_code.selected_options.first.text : b.restricted_status_code_readonly }
  value(:fo_principal_name_new) { |b| b.fo_principal_name.exists? ? b.fo_principal_name.value : b.fo_principal_name_readonly }
  value(:supervisor_principal_name_new) { |b| b.supervisor_principal_name.exists? ? b.supervisor_principal_name.value : b.supervisor_principal_name_readonly }
  value(:manager_principal_name_new) { |b| b.manager_principal_name.exists? ? b.manager_principal_name.value : b.manager_principal_name_readonly }
  value(:budget_record_level_code_new) { |b| b.budget_record_level_code.exists? ? b.budget_record_level_code.selected_options.first.text : b.budget_record_level_code_readonly }
  value(:sufficient_funds_code_new) { |b| b.sufficient_funds_code.exists? ? b.sufficient_funds_code.selected_options.first.text : b.sufficient_funds_code_readonly }
  value(:expense_guideline_text_new) { |b| b.expense_guideline_text.exists? ? b.expense_guideline_text.value : b.expense_guideline_text_readonly }
  value(:income_guideline_text_new) { |b| b.income_guideline_text.exists? ? b.income_guideline_text.value : b.income_guideline_text_readonly }
  value(:purpose_text_new) { |b| b.purpose_text.exists? ? b.purpose_text.value : b.purpose_text_readonly }
  value(:income_stream_financial_cost_code_new) { |b| b.income_stream_financial_cost_code.exists? ? b.income_stream_financial_cost_code.selected_options.first.text : b.income_stream_financial_cost_code_readonly }
  value(:income_stream_account_number_new) { |b| b.income_stream_account_number.exists? ? b.income_stream_account_number.value : b.income_stream_account_number_readonly }
  value(:account_expiration_date_new) { |b| b.account_expiration_date.exists? ? b.account_expiration_date.value : b.account_expiration_date_readonly }
  value(:contract_control_chart_of_accounts_code_new) { |b| b.contract_control_chart_of_accounts_code.exists? ? b.contract_control_chart_of_accounts_code.selected_options.first.text : b.contract_control_chart_of_accounts_code_readonly }
  value(:contract_control_account_number_new) { |b| b.contract_control_account_number.exists? ? b.contract_control_account_number.value : b.contract_control_account_number_readonly }
  value(:account_icr_type_code_new) { |b| b.account_icr_type_code.exists? ? b.account_icr_type_code.value : b.account_icr_type_code_readonly }
  value(:indirect_cost_rate_new) { |b| b.indirect_cost_rate.exists? ? b.indirect_cost_rate.value : b.indirect_cost_rate_readonly }
  value(:cfda_number_new) { |b| b.cfda_number.exists? ? b.cfda_number.value : b.cfda_number_readonly }
  value(:cg_account_responsibility_id_new) { |b| b.cg_account_responsibility_id.exists? ? b.cg_account_responsibility_id.value : b.cg_account_responsibility_id_readonly }

  value(:account_data_new) do |b|
    {
      chart_code:                b.chart_code_new,
      number:                    b.number_new,
      name:                      b.name_new,
      organization_code:         b.organization_code_new,
      campus_code:               b.campus_code_new,
      effective_date:            b.effective_date_new,
      postal_code:               b.postal_code_new,
      city:                      b.city_new,
      state:                     b.state_new,
      address:                   b.address_new,
      type_code:                 b.type_code_new,
      sub_fund_group_code:       b.sub_fund_group_code_new,
      higher_ed_funct_code:      b.higher_ed_funct_code_new,
      restricted_status_code:    b.restricted_status_code_new,
      fo_principal_name:         b.fo_principal_name_new,
      supervisor_principal_name: b.supervisor_principal_name_new,
      manager_principal_name:    b.manager_principal_name_new,
      budget_record_level_code:  b.budget_record_level_code_new,
      sufficient_funds_code:     b.sufficient_funds_code_new,
      expense_guideline_text:    b.expense_guideline_text_new,
      income_guideline_text:     b.income_guideline_text_new,
      purpose_text:              b.purpose_text_new,
      income_stream_financial_cost_code: b.income_stream_financial_cost_code_new,
      income_stream_account_number:      b.income_stream_account_number_new,
      account_expiration_date:           b.account_expiration_date_new,
      contract_control_chart_of_accounts_code: b.contract_control_chart_of_accounts_code_new,
      contract_control_account_number:         b.contract_control_account_number_new,
      account_icr_type_code:                   b.account_icr_type_code_new,
      indirect_cost_rate:                      b.indirect_cost_rate_new,
      cfda_number:                             b.cfda_number_new,
      cg_account_responsibility_id:            b.cg_account_responsibility_id_new
    }.merge(b.respond_to?(:account_extended_data_new) ? b.account_extended_data_new : Hash.new)
  end

  # Old
  value(:chart_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.chartOfAccountsCode.div').text.strip }
  value(:account_number_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountNumber.div').text.strip }
  alias_method :number_old, :account_number_old
  value(:name_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountName.div').text.strip }
  value(:organization_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.organizationCode.div').text.strip }
  value(:campus_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountPhysicalCampusCode.div').text.strip }
  value(:effective_date_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountEffectiveDate.div').text.strip }
  value(:postal_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountZipCode.div').text.strip }
  value(:city_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountCityName.div').text.strip }
  value(:state_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountStateCode.div').text.strip }
  value(:address_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountStreetAddress.div').text.strip }
  value(:type_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountTypeCode.div').text.strip }
  value(:sub_fund_group_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.subFundGroupCode.div').text.strip }
  value(:higher_ed_funct_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.financialHigherEdFunctionCd.div').text.strip }
  value(:restricted_status_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountRestrictedStatusCode.div').text.strip }
  value(:fo_principal_name_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountFiscalOfficerUser.name.div').parent.links[0].text.strip }
  value(:supervisor_principal_name_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountSupervisoryUser.name.div').parent.links[0].text.strip }
  value(:manager_principal_name_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountManagerUser.name.div').parent.links[0].text.strip }
  value(:budget_record_level_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.budgetRecordingLevelCode.div').text.strip }
  value(:sufficient_funds_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountSufficientFundsCode.div').text.strip }
  value(:expense_guideline_text_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountExpenseGuidelineText.div').text.strip }
  value(:income_guideline_text_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountIncomeGuidelineText.div').text.strip }
  value(:purpose_text_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountGuideline.accountPurposeText.div').text.strip }
  value(:income_stream_financial_cost_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.incomeStreamFinancialCoaCode.div').text.strip }
  value(:income_stream_account_number_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.incomeStreamAccountNumber.div').text.strip }
  value(:account_expiration_date_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountExpirationDate.div').text.strip }
  value(:contract_control_chart_of_accounts_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.contractControlFinCoaCode.div').text.strip }
  value(:contract_control_account_number_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.contractControlAccountNumber.div').text.strip }
  value(:account_icr_type_code_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.acctIndirectCostRcvyTypeCd.div').text.strip }
  value(:indirect_cost_rate_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.financialIcrSeriesIdentifier.div').text.strip }
  value(:cfda_number_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.accountCfdaNumber.div').text.strip }
  value(:cg_account_responsibility_id_old) { |b| b.frm.span(id: 'document.oldMaintainableObject.contractsAndGrantsAccountResponsibilityId.div').text.strip }

  value(:account_data_old) do |b|
    {
      chart_code:                b.chart_code_old,
      number:                    b.number_old,
      name:                      b.name_old,
      organization_code:         b.organization_code_old,
      campus_code:               b.campus_code_old,
      effective_date:            b.effective_date_old,
      postal_code:               b.postal_code_old,
      city:                      b.city_old,
      state:                     b.state_old,
      address:                   b.address_old,
      type_code:                 b.type_code_old,
      sub_fund_group_code:       b.sub_fund_group_code_old,
      higher_ed_funct_code:      b.higher_ed_funct_code_old,
      restricted_status_code:    b.restricted_status_code_old,
      fo_principal_name:         b.fo_principal_name_old,
      supervisor_principal_name: b.supervisor_principal_name_old,
      manager_principal_name:    b.manager_principal_name_old,
      budget_record_level_code:  b.budget_record_level_code_old,
      sufficient_funds_code:     b.sufficient_funds_code_old,
      expense_guideline_text:    b.expense_guideline_text_old,
      income_guideline_text:     b.income_guideline_text_old,
      purpose_text:              b.purpose_text_old,
      income_stream_financial_cost_code: b.income_stream_financial_cost_code_old,
      income_stream_account_number:      b.income_stream_account_number_old,
      account_expiration_date:           b.account_expiration_date_old,
      contract_control_chart_of_accounts_code: b.contract_control_chart_of_accounts_code_old,
      contract_control_account_number:         b.contract_control_account_number_old,
      account_icr_type_code:                   b.account_icr_type_code_old,
      indirect_cost_rate:                      b.indirect_cost_rate_old,
      cfda_number:                             b.cfda_number_old,
      cg_account_responsibility_id:            b.cg_account_responsibility_id_old,
      invoice_frequency_code:                  b.invoice_frequency_code_old,
      invoice_type_code:                       b.invoice_type_code_old
    }.merge(b.respond_to?(:account_extended_data_old) ? b.account_extended_data_old : Hash.new)
  end

  # Read-Only
  value(:chart_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.chartOfAccountsCode.div').text.strip }
  value(:number_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountNumber.div').text.strip }
  value(:name_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountName.div').text.strip }
  value(:organization_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.organizationCode.div').text.strip }
  value(:campus_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountPhysicalCampusCode.div').text.strip }
  value(:effective_date_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountEffectiveDate.div').text.strip }
  value(:postal_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountZipCode.div').text.strip }
  value(:city_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountCityName.div').text.strip }
  value(:state_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountStateCode.div').text.strip }
  value(:address_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountStreetAddress.div').text.strip }
  value(:type_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountTypeCode.div').text.strip }
  value(:sub_fund_group_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.subFundGroupCode.div').text.strip }
  value(:higher_ed_funct_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.financialHigherEdFunctionCd.div').text.strip }
  value(:restricted_status_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountRestrictedStatusCode.div').text.strip }
  value(:fo_principal_name_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountFiscalOfficerUser.name.div').parent.links[0].text.strip }
  value(:supervisor_principal_name_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountSupervisoryUser.name.div').parent.links[0].text.strip }
  value(:manager_principal_name_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountManagerUser.name.div').parent.links[0].text.strip }
  value(:budget_record_level_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.budgetRecordingLevelCode.div').text.strip }
  value(:sufficient_funds_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountSufficientFundsCode.div').text.strip }
  value(:expense_guideline_text_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountGuideline.accountExpenseGuidelineText.div').text.strip }
  value(:income_guideline_text_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountGuideline.accountIncomeGuidelineText.div').text.strip }
  value(:purpose_text_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountGuideline.accountPurposeText.div').text.strip }
  value(:income_stream_financial_cost_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.incomeStreamFinancialCoaCode.div').text.strip }
  value(:income_stream_account_number_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.incomeStreamAccountNumber.div').text.strip }
  value(:account_expiration_date_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountExpirationDate.div').text.strip }
  value(:contract_control_chart_of_accounts_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.contractControlFinCoaCode.div').text.strip }
  value(:contract_control_account_number_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.contractControlAccountNumber.div').text.strip }
  value(:account_icr_type_code_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.acctIndirectCostRcvyTypeCd.div').text.strip }
  value(:indirect_cost_rate_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.financialIcrSeriesIdentifier.div').text.strip }
  value(:cfda_number_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.accountCfdaNumber.div').text.strip }
  value(:cg_account_responsibility_id_readonly) { |b| b.frm.span(id: 'document.newMaintainableObject.contractsAndGrantsAccountResponsibilityId.div').text.strip }

  value(:account_data_readonly) do |b|
    {
        chart_code:                b.chart_code_readonly,
        number:                    b.number_readonly,
        name:                      b.name_readonly,
        organization_code:         b.organization_code_readonly,
        campus_code:               b.campus_code_readonly,
        effective_date:            b.effective_date_readonly,
        postal_code:               b.postal_code_readonly,
        city:                      b.city_readonly,
        state:                     b.state_readonly,
        address:                   b.address_readonly,
        type_code:                 b.type_code_readonly,
        sub_fund_group_code:       b.sub_fund_group_code_readonly,
        higher_ed_funct_code:      b.higher_ed_funct_code_readonly,
        restricted_status_code:    b.restricted_status_code_readonly,
        fo_principal_name:         b.fo_principal_name_readonly,
        supervisor_principal_name: b.supervisor_principal_name_readonly,
        manager_principal_name:    b.manager_principal_name_readonly,
        budget_record_level_code:  b.budget_record_level_code_readonly,
        sufficient_funds_code:     b.sufficient_funds_code_readonly,
        expense_guideline_text:    b.expense_guideline_text_readonly,
        income_guideline_text:     b.income_guideline_text_readonly,
        purpose_text:              b.purpose_text_readonly,
        income_stream_financial_cost_code: b.income_stream_financial_cost_code_readonly,
        income_stream_account_number:      b.income_stream_account_number_readonly,
        account_expiration_date:           b.account_expiration_date_readonly,
        contract_control_chart_of_accounts_code: b.contract_control_chart_of_accounts_code_readonly,
        contract_control_account_number:         b.contract_control_account_number_readonly,
        account_icr_type_code:                   b.account_icr_type_code_readonly,
        indirect_cost_rate:                      b.indirect_cost_rate_readonly,
        cfda_number:                             b.cfda_number_readonly,
        cg_account_responsibility_id:            b.cg_account_responsibility_id_readonly,
        invoice_frequency_code:                  b.invoice_frequency_code_readonly,
        invoice_type_code:                       b.invoice_type_code_readonly
    }.merge(b.respond_to?(:account_extended_data_readonly) ? b.account_extended_data_readonly : Hash.new)
  end

  value(:account_maintenance_errors) { |b| b.frm.div(id: 'tab-AccountMaintenance-div').div(class: 'left-errmsg-tab').div.divs.collect{ |div| div.text }  }

  element(:error_icon) { |b| b.frm.image(alt: 'error') }

end