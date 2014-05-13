class OrganizationObject < KFSDataObject

  attr_accessor :chart_code, :organization_code, :name, :manager_principal_name, :resp_center_code,
                :physcal_campus_code, :type_code, :default_account_number,
                :address_line_1, :address_line_2, :postal_code, :country_code,
                :begin_date, :end_date, :reports_to_chart_code, :reports_to_org_code, :active,
                :plant_chart, :plant_account_number, :campus_plant_chart_code, :campus_plant_account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:            random_alphanums(40, 'AFT'),
        chart_code:             get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        organization_code:      random_alphanums(4),
        name:                   random_alphanums(10, 'AFT'),
        manager_principal_name: get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER),
        resp_center_code:       'NA',
        physcal_campus_code:    get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        type_code:              get_aft_parameter_value(ParameterConstants::DEFAULT_ORGANIZATION_TYPE_CODE_WITH_NAME),
        address_line_1:         get_generic_address_1,
        address_line_2:         get_generic_address_2,
        postal_code:            get_random_postal_code('*'),
        country_code:           'United States',
        begin_date:             '01/01/2010',
        reports_to_chart_code:  get_aft_parameter_value(ParameterConstants::DEFAULT_REPORTS_TO_CHART_CODE),
        reports_to_org_code:    get_aft_parameter_value(ParameterConstants::DEFAULT_REPORTS_TO_ORGANIZATION_CODE),
        plant_chart:            get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        plant_account_number:   get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNT_NUMBER),
        campus_plant_chart_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        campus_plant_account_number: get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNT_NUMBER),
        #press:                       :save
    }
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ORGANIZATION)).merge(opts))
  end

  def build
    visit(MainPage).organization
    on(OrganizationLookupPage).create
    on OrganizationPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :organization_code, :name, :manager_principal_name, :resp_center_code,
                     :physcal_campus_code, :type_code,
                     :address_line_1, :address_line_2, :postal_code, :country_code,
                     :begin_date, :end_date, :reports_to_chart_code, :reports_to_org_code
    end
  end

end