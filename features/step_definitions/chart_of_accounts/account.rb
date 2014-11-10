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
  random_continuation_account_number = @account.number
  visit(MainPage).account
  on AccountLookupPage do |page|
    # First, let's get a random continuation account
    begin
      random_continuation_account_number = page.get_random_account_number
    end while random_continuation_account_number == @account.number

    # Now, let's try to close that account
    page.chart_code.fit     @account.chart_code
    page.account_number.fit @account.number
    page.closed_no.set # There's no point in doing this if the account is already closed. Probably want an error, if a search with this setting fails.
    page.search
    page.edit_random # should only select the guy we want, after all
  end
  @account.edit description:                 "Closing Account #{@account.number}",
                continuation_account_number: random_continuation_account_number,
                continuation_chart_code:     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME),
                account_expiration_date:     on(AccountPage).effective_date.value,
                closed:                      :set
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
  #on(AccountPage) { |page| page.continuation_account_number.fit page.original_account_number }
  @account.edit continuation_account_number: on(AccountPage).account_number_old # TODO: It may be more reliable to pull this from the webservice
end

And /^I clone a random Account with the following changes:$/ do |table|
  step 'I clone Account nil with the following changes:', table
end

And /^I extend the Expiration Date of the Account document (\d+) days$/ do |days|
  #on(AccountPage).account_expiration_date.fit (@account.account_expiration_date + days.to_i).strftime('%m/%d/%Y')
  @account.edit account_expiration_date: (@account.account_expiration_date + days.to_i).strftime('%m/%d/%Y')
end

And /^I clone a random Account with name, chart code, and description changes$/ do
  step 'I clone Account nil with the following changes:',
       table(%Q{
         | Name        | #{random_alphanums(15, 'AFT')}                                      |
         | Chart Code  | #{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}  |
         | Description | #{random_alphanums(40, 'AFT')}                                      |
       })
end

And /^I edit an Account with a random Sub-Fund Group Code$/ do
  account_number = get_kuali_business_object('KFS-COA',
                                             'Account',
                                             'subFundGroupCode=*&extension.programCode=*&closed=N&extension.appropriationAccountNumber=*&active=Y&accountExpirationDate=NULL')['accountNumber'].sample
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.account_number.fit account_number
    page.search
    page.edit_random
  end
end

When /^I enter an invalid (.*)$/  do |field_name|
  case field_name
    when 'Sub-Fund Program Code'
      step "I enter a Sub-Fund Program Code of #{random_alphanums(4, 'XX').upcase}"
    when 'Major Reporting Category Code'
      step "I enter #{random_alphanums(6, 'XX').upcase} as an invalid Major Reporting Category Code"
    when 'Appropriation Account Number'
      step "I enter #{random_alphanums(6, 'XX').upcase} as an invalid Appropriation Account Number"
    when 'Labor Benefit Rate Code'
      step "I enter #{random_alphanums(1, 'X').upcase} as an invalid Labor Benefit Rate Category Code"
  end
end


Then /^I should get (invalid|an invalid) (.*) errors?$/ do |invalid_ind, error_field|
  on AccountPage do |page|
    case error_field
      when 'Sub-Fund Program Code'
        page.errors.should include "Sub-Fund Program Code #{page.subfund_program_code.value} is not associated with Sub-Fund Group Code #{page.sub_fund_group_code.value}."
      when 'Major Reporting Category Code'
        page.errors.should include "Major Reporting Category Code (#{page.major_reporting_category_code.value}) does not exist."
      when 'Appropriation Account Number'
        page.errors.should include "Appropriation Account Number #{page.appropriation_account_number.value} is not associated with Sub-Fund Group Code #{page.sub_fund_group_code.value}."
      when 'Labor Benefit Rate Code'
        page.errors.should include 'Invalid Labor Benefit Rate Code'
        page.errors.should include "The specified Labor Benefit Rate Category Code #{page.labor_benefit_rate_category_code.value} does not exist."
    end
  end
end


And /^I enter (Sub Fund Program Code|Sub Fund Program Code and Appropriation Account Number) that (is|are) associated with a random Sub Fund Group Code$/ do |codes, is_are|
  account = get_kuali_business_object('KFS-COA','Account','subFundGroupCode=*&extension.programCode=*&closed=N&extension.appropriationAccountNumber=*&active=Y&accountExpirationDate=NULL')
  on AccountPage do |page|
    page.sub_fund_group_code.set account['subFundGroup.codeAndDescription'].sample.split('-')[0].strip
    page.subfund_program_code.set account['extension.programCode'].sample
    unless codes == 'Sub Fund Program Code'
      page.appropriation_account_number.set account['extension.appropriationAccountNumber'].sample
    end
  end
end

And /^I enter Appropriation Account Number that is not associated with the Sub Fund Group Code$/  do
  # the account# is not used as its own appropriation account#
  @account.edit appropriation_account_number: on(AccountPage).account_number_old # TODO: It may be more reliable to pull this from the webservice
end

And /^I create an Account and leave blank for the fields of Guidelines and Purpose tab$/ do
  @account = create AccountObject, expense_guideline_text: '',
                                   income_guideline_text:  '',
                                   purpose_text:           '',
                                   press:                  nil
end
