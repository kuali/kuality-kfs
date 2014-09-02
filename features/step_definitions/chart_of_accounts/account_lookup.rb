When /^I access Account Lookup$/ do
  visit(MainPage).account
end

Then /^the Account Lookup page should appear$/ do
  on AccountLookupPage do |page|
    page.chart_code.should exist
  end
end

When /^I search for all accounts$/ do
  on(AccountLookupPage).search
end

When /^The Account is found$/ do
  on AccountLookupPage do |page|
    page.item_row('0142900').should exist
  end
end

When /^Accounts should be returned$/ do
  on AccountLookupPage do |page|
    page.results_table.should exist
  end
end

When /^I lookup an Account with (.*)$/ do |field_name|
  on AccountLookupPage do |page|
    case
      when field_name == 'Account Manager Principal Name '
        page.acct_manager_principal_name.set get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER)
      when field_name == 'Account Supervisor Principal Name'
        page.acct_supervisor_principal_name.set get_aft_parameter_value(ParameterConstants::DEFAULT_SUPERVISOR)
    end
    page.search
  end
end