Given /^I am logged in as a KFS Technical Administrator$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Technical Administrator'))
end

Given /^I am logged in as a KFS Operations$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-SYS', 'Operations'))
end

Given /^I am logged in as a Vendor Reviewer$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-VND', 'Reviewer Omit Initiator'))
end

Given /^I am logged in as a Vendor Initiator$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-VND', 'CU Vendor Initiator'))
end

Given /^I am logged in as a KFS Fiscal Officer$/ do
  perform_backdoor_login(get_aft_parameter_value(ParameterConstants::DEFAULT_FISCAL_OFFICER))
end

Given /^I am logged in as a KFS Fiscal Officer for account number (.*)$/ do |account_number|
  account_info = get_kuali_business_object('KFS-COA','Account','accountNumber=' + account_number)
  fiscal_officer_principal_name = account_info['accountFiscalOfficerUser.principalName']
  perform_backdoor_login(fiscal_officer_principal_name)
end

Given /^I am logged in as a KFS User$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'User'))
end

Given /^I am logged in as "([^"]*)"$/ do |user_id|
  perform_backdoor_login(user_id)
end

Given /^I am logged in as a KFS Chart Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Chart Manager'))
end

Given /^I am logged in as a KFS Chart Administrator$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Chart Administrator (cu)'))
end

Given /^I am logged in as a KFS Cash Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-FP', 'Cash Manager'))
end

Given /^I am logged in as a KFS Contracts & Grants Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Contracts & Grants Manager'))
end

Given /^I am logged in as a KFS Contracts & Grants Processor$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Contracts & Grants Processor'))
end

Given /^I am logged in as a KFS Parameter Change Administrator$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KR-NS', 'Parameter Approver (cu)'))
end

Given /^I am logged in as a KFS System Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Manager'))
end

Given /^I am logged in as a KFS User for the (.*) document$/ do |eDoc|
  perform_backdoor_login(get_document_initiator(eDoc))
end

Given /^I am logged in as a KFS Manager for the (.*) document$/ do |eDoc|
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Workflow Administrator'))
end

Given /^I am logged in as a Disbursement Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-FP', 'Disbursement Manager'))
end

Given /^I am logged in as a Tax Manager$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Tax Manager'))
end

Given /^I am logged in as a Disbursement Method Reviewer$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-SYS', 'Disbursement Method Reviewer'))
end

And /^I am logged in as a PURAP Contract Manager$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-PURAP', 'Contract Manager'))
end

Given /^I am logged in as a Purchasing Processor$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-PURAP', 'Purchasing Processor'))
end

Given /^I am logged in as a Commodity Reviewer$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-SYS', 'Commodity Reviewer'))
end

Given /^I am logged in as FTC\/BSC member User$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-SYS', 'FTC/BSC members'))
end

Given /^I am logged in as a Vendor Contract Editor\(cu\)$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-PURAP', 'Vendor Contract Editor(cu)'))
end

Given /^I am logged in as a (.*) principal in namespace (.*)$/ do |role, namespace|
  perform_backdoor_login(get_first_principal_name_for_role(role, namespace))
end

Given /^I am logged in as a Vendor Attachment viewer \(cu\)$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-VND', 'Vendor Attachment viewer (cu)'))
end

Given /^I login as a Accounts Payable Processor to create a PREQ$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-PURAP', 'Accounts Payable Processor'))
end

Given /^I am logged in as a KFS Parameter Change Approver$/ do
  #visit(BackdoorLoginPage).login_as(get_first_principal_name_for_role('KR-NS', 'Parameter Approver (cu) KFS')) # TODO: Get role from service
  perform_backdoor_login('ccs1')
end

Given /^I Login as a PDP Format Disbursement Processor$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-PDP', 'Processor'))
end

Given /^I am logged in as a Salary Transfer Initiator$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-LD', 'Salary Transfer Initiator (cu)'))
end

Given /^I am logged in as a Labor Distribution Manager$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-LD', 'Labor Distribution Manager (cu)'))
end

# This Cucumber step takes the User principal name so the application login can be performed as that user.
Given  /^I am User (.*) who is a Salary Transfer Initiator$/ do |principal_name|
  perform_backdoor_login(principal_name)
end

Given /^I Login as a Benefit Transfer Initiator$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-LD', 'BT Initiator (cu)'))
end

Given /^I Login as an Asset Processor$/ do
  perform_backdoor_login(get_first_principal_name_for_role('KFS-SYS', 'Asset Processor'))
end

Given /^I am logged in as an e\-SHOP User$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-PURAP', 'eShop User (cu)'))
end

Given /^I am logged in as an e\-SHOP User with a phone number$/ do
  perform_backdoor_login(get_random_principal_with_phone_name_for_role('KFS-PURAP', 'eShop Plus User(cu)'))
end

Given /^I am logged in as an e\-SHOP Plus User$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-PURAP', 'eShop Plus User(cu)'))
end

Given /^I am logged in as an e\-SHOP Shopper Office User$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-PURAP', 'eShop Shopper Office(cu)'))
end

Given /^I am logged in as the Initiator of the (.*) document$/ do |document|
  # this is not to find the document initiator role.  It is the 'initiator' who created the particular document for this scenario
  step "I am logged in as \"#{document_object_for(document).initiator}\""
end

Given /^I am logged in as a Vendor Initiator and Manager$/ do
  # initiator can edit Vendor and Manager can blanket approve vendor
  managers = get_principal_name_for_role('KFS-SYS', 'Manager')
  initiators = get_principal_name_for_role('KFS-VND', 'CU Vendor Initiator')
  users = managers & initiators
  perform_backdoor_login(users.sample)
end

Given /^I am logged in as a (Source|Target|From|To) Account Fiscal Officer$/ do |acct_type|
  if acct_type == 'Source' || acct_type == 'From'
    acct_number = on(AccountingLine).result_source_account_number(0)
  else
    acct_number = on(AccountingLine).result_target_account_number(0)
  end
  step "I am logged in as a KFS Fiscal Officer for account number #{acct_number}"
end

And /^I am logged in as the adhoc user$/ do
  step "I am logged in as \"#{@adhoc_user}\""
end

Given /^I login as a KFS user to create an REQS$/ do
  perform_backdoor_login(get_aft_parameter_value(ParameterConstants::DEFAULT_REQS_INITIATOR))
end

Given /^I am logged in as a Sensitive Data Viewer$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KFS-PURAP', 'Sensitive Data Viewer'))
end

Given /^I am logged in as an e\-SHOP Plus User without a favorite account$/ do
  perform_backdoor_login(get_random_principal_without_favorite_account_for_role('KFS-PURAP', 'eShop Plus User(cu)'))
end

Given /^I am logged in as a KR Technical Administrator$/ do
  perform_backdoor_login(get_random_principal_name_for_role('KR-SYS', 'Technical Administrator'))
end

And /^I remember the logged in user$/ do
  @remembered_logged_in_user = get_current_user
end

And /^I am logged in as the remembered user$/ do
  perform_backdoor_login(@remembered_logged_in_user)
end
