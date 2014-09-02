And /^I copy an Account$/ do
  on(AccountLookupPage).copy_random
  on AccountPage do |page|
    page.description.fit 'AFT testing copy'
    page.chart_code.fit get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    page.number.fit random_alphanums(4, 'AFT')
    @account = make AccountObject
    @account.chart_code = page.chart_code.text
    @account.number = page.number.text
    @account.description = page.description
    @account.document_id = page.document_id
    @document_id = page.document_id
    page.save
    page.left_errmsg_text.should include 'Document was successfully saved.'
  end
end

And /^I save an Account with a lower case Sub Fund Program$/ do
  @account = create AccountObject, sub_fund_group_code: 'board', press: :save
end

When /^I submit an account with blank SubFund group Code$/ do
  @account = create AccountObject, sub_fund_group_code: '', press: :submit
end

Then /^I should get an error on saving that I left the SubFund Group Code field blank$/ do
  on(AccountPage).errors.should include 'Sub-Fund Group Code (SubFundGrpCd) is a required field.'
end

Then /^the Account Maintenance Document saves with no errors$/  do
  on(AccountPage).document_status.should == 'SAVED'
end

Then /^the Account Maintenance Document has no errors$/  do
  on(AccountPage).document_status.should == 'ENROUTE'
end

Then /^an error in the (.*) tab should say "(.*)"$/ do |tab, error|
  hash = {'Account Maintenance' => :account_maintenance_errors}

  on AccountPage do |page|
    page.send(hash[tab]).should include error
  end

end

And /^I edit an Account with a Sub-Fund Group Code of (.*)/ do |sub_fund_group_code|
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.sub_fund_group_code.fit sub_fund_group_code
    page.search
    page.edit_random
  end
end

When /^I enter (.*) as an invalid Labor Benefit Rate Category Code$/  do |labor_benefit_rate_category_code|
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.labor_benefit_rate_category_code.fit labor_benefit_rate_category_code
    page.save
  end
end

And /^I edit an Account$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.search
    page.edit_random
  end
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    @account.document_id = page.document_id
    @account.description = page.description
  end
end

And /^I enter Sub Fund Group Code of (.*)/ do |sub_fund_group_code|
  on(AccountPage).sub_fund_group_code.set sub_fund_group_code
end

And /^I enter Sub Fund Program Code of (.*)/  do |subfund_program_code|
  on(AccountPage).subfund_program_code.set subfund_program_code
end

And /^I close the Account$/ do
  visit(MainPage).account

  # First, let's get a random continuation account
  random_continuation_account_number = on(AccountLookupPage).get_random_account_number
  # Now, let's try to close that account
  on AccountLookupPage do |page|
    page.chart_code.fit     @account.chart_code
    page.account_number.fit @account.number
    page.closed_no.set # There's no point in doing this if the account is already closed. Probably want an error, if a search with this setting fails.
    page.search
    page.edit_random # should only select the guy we want, after all
  end
  on AccountPage do |page|
    page.description.fit                 "Closing Account #{@account.number}"
    page.continuation_account_number.fit random_continuation_account_number
    page.continuation_chart_code.fit     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME)
    page.account_expiration_date.fit     page.effective_date.value
    page.closed.set
  end
end

And /^I edit the Account$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.chart_code.fit @account.chart_code
    page.account_number.fit @account.number
    page.search
    page.edit_random
  end
  on AccountPage do |page|
    page.description.fit 'AFT testing edit'
    @account.description = 'AFT testing edit'
    @account.document_id = page.document_id
  end
end

And /^I enter a Continuation Chart Of Accounts Code that equals the Chart of Account Code$/ do
  on(AccountPage) { |page| page.continuation_chart_code.fit page.chart_code.text }
end

And /^I enter a Continuation Account Number that equals the Account Number$/ do
  on(AccountPage) { |page| page.continuation_account_number.fit page.original_account_number }
end

Then /^an empty error should appear$/ do
  on AccountPage do |page|
    page.error_message_of('').should exist
  end
end

And /^I clone a random Account with the following changes:$/ do |table|
  step "I clone Account nil with the following changes:", table
end

And /^I extend the Expiration Date of the Account document (\d+) days$/ do |days|
  on(AccountPage).account_expiration_date.fit (@account.account_expiration_date + days.to_i).strftime('%m/%d/%Y')
end

And /^I use these Accounts:$/ do |table|
  existing_accounts = table.raw.flatten

  visit(MainPage).account
  on AccountLookupPage do |page|
    existing_accounts.each do |account_number|
      page.chart_code.fit     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
      page.account_number.fit account_number
      page.search

      # We're only really interested in these parts
      @account = make AccountObject
      @account.number = page.results_table[1][page.column_index(:account_number)].text
      @account.chart_code = page.results_table[1][page.column_index(:chart_code)].text
      @accounts = @accounts.nil? ? [@account] : @accounts + [@account]
    end
  end
end
