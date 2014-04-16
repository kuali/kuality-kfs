class ObjectCodeObject < KFSDataObject

  attr_accessor :fiscal_year,
      :new_chart_code,
      :object_code,
      :object_code_name,
      :object_code_short_name,
      :reports_to_object_code,
      :object_type_code,
      :level_code,
      :object_sub_type_code,
      :financial_object_code_description,
      :cg_reporting_code,
      :historical_financial_object_code,
      :active_indicator,
      :budget_aggregation_code,
      :mandatory_transfer,
      :federal_funded_code,
      :next_year_object_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description: random_alphanums(20, ' AFT'),
        fiscal_year:   '2014',
        new_chart_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE_WITH_NAME),
        object_code: random_alphanums(4), #if object code matches data user gets an error 'This document cannot be Saved or Routed because a record with the same primary key already exists.'
        object_code_name: random_alphanums(10, 'AFT'),
        object_code_short_name: random_alphanums(5, 'AFT'),
        reports_to_object_code: 'A000',#TODO config?
        object_type_code: 'ES',#TODO config?
        level_code:    'BADJ',#TODO config?
        object_sub_type_code: 'BI',#TODO config?
        financial_object_code_description: random_alphanums(30, 'AFT'),
        cg_reporting_code:      '06SM',#TODO config?
        budget_aggregation_code: 'L',#TODO config?
        mandatory_transfer: '::random::',
        federal_funded_code: '::random::',
        press: :save

    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).object_code
    on(ObjectCodeLookupPage).create_new
    on ObjectCodePage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description,
              :fiscal_year, :new_chart_code, :object_code, :object_code_name,
              :object_code_short_name, :reports_to_object_code, :object_type_code,
              :level_code, :object_sub_type_code, :financial_object_code_description,
              :cg_reporting_code, :historical_financial_object_code, :budget_aggregation_code,
              :mandatory_transfer, :federal_funded_code, :next_year_object_code
    end
  end
end #class
