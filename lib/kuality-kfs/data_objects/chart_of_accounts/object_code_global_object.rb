class ObjectCodeGlobalObject < KFSDataObject

  attr_accessor :object_code,
                :object_code_name,
                :object_code_short_name,
                :reports_to_object_code,
                :object_type_code,
                :level_code,
                :cg_reporting_code,
                :object_sub_type_code,
                :financial_object_code_description,
                :historical_financial_object_code,
                :budget_aggregation_code,
                :mandatory_transfer,
                :federal_funded_code,
                :next_year_object_code,
                :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:             'ATF Test 594/639 Expense Object Code ' + random_alphanums(5, ' AFT'),
        object_code:             random_alphanums(2, '65'), #if object code matches data user gets an error 'This document cannot be Saved or Routed because a record with the same primary key already exists.'
        object_code_name:        'Supplies - Classroom ' + random_alphanums(10, 'AFT'),
        object_code_short_name:  'Classroom',
        financial_object_code_description: random_alphanums(30, 'AFT'),
        mandatory_transfer:      'N - NOT APPLICABLE',
        federal_funded_code:     'N - Attribute Not Used at Cornell',
        new_year_chart_code:      get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME),
        press: :save
    }
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_OBJECT_CODE_GLOBAL)).merge(opts))
  end

  def build
    visit(MainPage).object_code_global
    on ObjectCodeGlobalPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description,
               :object_code, :object_code_name, :object_code_short_name,
               :reports_to_object_code, :object_type_code,
               :level_code, :object_sub_type_code, :financial_object_code_description,
               :cg_reporting_code, :budget_aggregation_code, :mandatory_transfer,
               :federal_funded_code, :next_year_object_code, :new_year_chart_code
      page.add_chart_code
    end
  end

end #class
