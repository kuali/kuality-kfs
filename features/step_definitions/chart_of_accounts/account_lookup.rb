When /^I access Account Lookup$/ do
  visit(MainPage).account
end

Then /^the Account Lookup page should appear$/ do
  on(AccountLookupPage).chart_code.should exist
end

When /^I search for all accounts$/ do
  on(AccountLookupPage).search
end

When /^Accounts should be returned$/ do
  on(AccountLookupPage).results_table.should exist
end

When /^I lookup an Account with (.*)$/ do |field_name|
  on AccountLookupPage do |page|
    case field_name
      when 'Account Manager Principal Name'
        page.acct_manager_principal_name.set get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER)
      when 'Account Supervisor Principal Name'
        page.acct_supervisor_principal_name.set get_aft_parameter_value(ParameterConstants::DEFAULT_SUPERVISOR)
    end
    page.search
  end
end