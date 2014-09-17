Then /^the Object Code Lookup page should appear$/ do
  on(ObjectCodeLookupPage).chart_code.should exist
end

When /^I lookup an Object Code with Chart Code of (.*) and Sub Type Code of (.*)$/ do |chart_code, sub_type_code|
  on ObjectCodeLookupPage do |page|
    page.chart_code.set chart_code
    page.sub_type_code.set sub_type_code
    page.search
  end
end

And /^I lookup an Object Code with that Object Sub Type$/ do
  visit(MainPage).object_code
  on ObjectCodeLookupPage do |page|
    while true
      page.chart_code.fit get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME)
      page.object_sub_type_code.fit @parameter_values.sample
      page.search
      break if page.results_table != []
    end
    @lookup_object_code = page.get_random_object_code
  end
end