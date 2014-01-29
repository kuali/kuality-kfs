class SubObjectCodeGlobalObject < KFSDataObject

  attr_accessor  :new_chart_code,
                 :organization_document_number,
                 :new_fiscal_year, :new_chart_code, :new_sub_object_code, :new_sub_object_code_name, :new_sub_object_code_short_name,
                 :noc_fiscal_year, :noc_chart_code, :noc_object_code,
                 :na_chart_code, :na_account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                    random_alphanums(40, 'AFT'),
        new_chart_code:                 'IT - Ithaca Campus', #TODO grab this from config file
        organization_document_number:   '1000710', #TODO get from config
        new_fiscal_year:                '2014',
        new_sub_object_code:            'tst',
        new_sub_object_code_name:       random_alphanums(20, 'AFT'),
        new_sub_object_code_short_name: random_alphanums(5, 'ATF'),
        noc_fiscal_year:                '2014',
        noc_chart_code:                 'IT - Ithaca Campus', #TODO grab this from config file
        noc_object_code:                '1000',
        na_chart_code:                  'IT - Ithaca Campus', #TODO grab this from config file
        na_account_number:              '1000710',
        press:                          :save

    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).sub_object_code_global
    on SubObjectCodeGlobalPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page,  :description, :new_chart_code,
                      :organization_document_number,
                      :new_fiscal_year, :new_chart_code, :new_sub_object_code, :new_sub_object_code_name, :new_sub_object_code_short_name,
                      :noc_fiscal_year, :noc_chart_code, :noc_object_code,
                      :na_chart_code, :na_account_number
    end
  end

  def add_multiple_account_lines(search_code)
    on(SubObjectCodeGlobalPage).add_multiple_account_lines
    on AccountLookupPage do |page|
      page.organization_code.fit "#{search_code}"
      page.search
      page.select_all_from_this_page
      page.return_selected
    end
  end

end #class
