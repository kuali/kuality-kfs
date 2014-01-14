class ObjectCodeGlobalObject < DataObject

#  include Navigation
  include DateFactory
  include StringFactory


  attr_accessor :description,
                :object_code,
                :object_code_name,
                :object_code_short_name,
                :reports_to_object_code,
                :object_type_code,
                :level_code,
                :cg_reporting_code,

                :object_sub_type_code,
                :suny_object_code,
                :financial_object_code_description,

                :historical_financial_object_code,

                :budget_aggregation_code,
                :mandatory_transfer,
                :federal_funded_code,
                :next_year_object_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:             'ATF Test 594/639 Expense Object Code ' + random_alphanums(5, ' AFT'),
        object_code:             random_alphanums(2, '65'), #if object code matches data user gets an error 'This document cannot be Saved or Routed because a record with the same primary key already exists.'
        object_code_name:        'Supplies - Classroom ' + random_alphanums(10, 'AFT'),
        object_code_short_name:  'Classroom',
        reports_to_object_code:  'E370',
        object_type_code:        'EX',
        level_code:              'SMAT',
        cg_reporting_code:       '06SM',

        object_sub_type_code:    'OE',

        financial_object_code_description: random_alphanums(30, 'AFT'),
        budget_aggregation_code: 'O',
        mandatory_transfer: 'N - NOT APPLICABLE', # ::random::',
        federal_funded_code: 'N - Attribute Not Used at Cornell' #'::random::'

    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).object_code_global
    #on(ObjectCodeLookupPage).create_new
    on ObjectCodeGlobalPage do |page|
      #page.description.focus
      #page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description,
               :object_code, :object_code_name, :object_code_short_name,
               :reports_to_object_code, :object_type_code,
               :level_code, :object_sub_type_code, :financial_object_code_description,
               :cg_reporting_code, :budget_aggregation_code, :mandatory_transfer,
               :federal_funded_code, :next_year_object_code

      #Cornell
      fill_out page, :suny_object_code

      page.save
      @document_id = page.document_id
    end
  end



end #class
