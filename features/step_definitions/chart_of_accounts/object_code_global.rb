And /^I enter an invalid CG Reporting Code of (.*)$/ do |invalid_code|
  on(ObjectCodeGlobalPage).cg_reporting_code.fit invalid_code
end

Then /^Object Code Global should show an error that says (.*?)$/ do |error|
  on(ObjectCodeGlobalPage).errors.should include error
end