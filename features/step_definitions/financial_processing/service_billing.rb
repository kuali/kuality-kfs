When /^I start an empty Service Billing document$/ do
  @service_billing = create ServiceBillingObject
end

When /^I attempt to start an empty Service Billing document$/ do
  visit(MainPage).service_billing
end


And /^I lookup a Service Bill Processor as initiator and an associated account as source account$/ do
  step 'I am logged in as a KR Technical Administrator'
  visit(AdministrationPage).role
  on RoleLookup do |lookup|
    lookup.id.fit      '13'
    lookup.search
    lookup.edit_random # There can only be one!
  end
  # puts on(RolePage).frm.div(id: 'tab-Assignees-div').tables[2].rows.length
  on RolePage do |page|
    random_row = rand(2..page.member_table.rows.length - 1)
    @sb_account = page.member_table[random_row][8].text
    step "I am logged in as \"#{page.member_table[random_row][4].text}\""
  end

end
