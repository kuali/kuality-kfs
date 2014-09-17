When /^I lookup a Rate ID using an alpha\-numeric value in the Indirect Cost Recovery Rate table$/ do
  visit(MaintenancePage).indirect_cost_recovery_rate

  on IndirectCostRecoveryRateLookupPage do |page|
   page.rate_id.set 'EC1'
   page.search
  end
end