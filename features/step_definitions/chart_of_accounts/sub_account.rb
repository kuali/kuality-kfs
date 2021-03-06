And /^I Create a Sub-Account with the default Sub-Account Type Code$/ do
  type_code = get_aft_parameter_value(ParameterConstants::DFAULT_SUB_ACCOUNT_TYPE_CODE)
  @sub_account = create SubAccountObject, type_code: type_code, press: :save
end

When /^I tab away from the Account Number field$/ do
  on SubAccountPage do |page|
    page.account_number.select
    page.account_number.send_keys :tab
  end
end

Then /^The Indirect Cost Rate ID field should not be null$/ do
  on(SubAccountPage).icr_identifier.value.should == ''
end

And /^I am logged in as the FO of the Account$/ do
  sleep(1)
  step "I am logged in as \"#{@account.accountFiscalOfficerUser.principalName}\""
  @user_id = @account.accountFiscalOfficerUser.principalNam
end

And /^I am logged in as the FO of the Sub-Account$/ do
  sleep(1)
  account_info = get_kuali_business_object('KFS-COA','Account',"accountNumber=#{@sub_account.account_number}")
  fiscal_officer_principal_name = account_info['accountFiscalOfficerUser.principalName'][0]
  step "I am logged in as \"#{fiscal_officer_principal_name}\""
  @user_id = fiscal_officer_principal_name
end

And /^The Sub-Account document should be in my action list$/ do
  sleep(5)
  on ActionList do |page|
    page.view_as(@user_id)
    page.last if on(ActionList).last_link.exists?
    page.result_item(@sub_account.document_id).should exist
  end
end

And /^I (#{SubAccountPage::available_buttons}) a Sub-Account with an adhoc approver$/ do |button|
  #The requirement for @KFSQA-589 is C&G processor as adhoc user
  @adhoc_user = get_random_principal_name_for_role('KFS-SYS', 'Contracts & Grants Processor')
  @user_id = @adhoc_user # for actionlist check
  account_number = ""
  i = 0
  while account_number.empty? && i < 10
    # must be an account that can have subaccounttype of 'CS'
    sub_account_info = get_kuali_business_object('KFS-COA','SubAccount','active=true&a21SubAccount.subAccountTypeCode=CS&chartOfAccountsCode=' + get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE))
    account_number = sub_account_info['accountNumber'][0]
    account_info = get_kuali_business_object('KFS-COA','Account',"accountNumber=#{account_number}")
    # check if account is closed or expired
    if account_info['closed'][0] == 'true'
      account_number = ""
    else
      if (account_info['accountExpirationDate'][0]) != 'null' && DateTime.strptime(account_info['accountExpirationDate'][0], '%Y-%m-%d') < DateTime.now
        account_number = ""
      end
    end
    i += 1
  end

  options = {
      account_number:                      account_number,
      cost_sharing_chart_of_accounts_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME),
      cost_share_account_number:           account_number,
      sub_account_type_code:               'CS',
      cost_sharing_account_number:         account_number,
      adhoc_approver_userid:               @adhoc_user,
      press:                               button.gsub(' ', '_')
  }

  @sub_account = create SubAccountObject, options
end

And /^I create a Sub-Account with Sub-Account Type Code (\w+)$/ do |sub_account_type|
  # only certain subfundgroupcode are acceptable for CS subaccount 'APFEDL' is one of them
  account_number =   get_kuali_business_object('KFS-COA','Account',"subFundGroupCode=APFEDL&active=Y&accountExpirationDate=NULL&chartOfAccountsCode=#{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}")['accountNumber'].sample
  options = {
      account_number:                      account_number,
      cost_sharing_chart_of_accounts_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
      cost_share_account_number:           account_number, # just need some account to fill in this required field
      sub_account_type_code:               sub_account_type,
      cost_sharing_account_number:         account_number,
      press:                               'save'
  }
  @sub_account = create SubAccountObject, options
end