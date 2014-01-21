class OrganizationObject < KFSDataObject

  attr_accessor :chart_code, :org_code, :name, :manager_principal_name, :resp_center_code,
                :physcal_campus_code, :type_code, :default_account_number,
                :address_line_1, :address_line_2, :postal_code, :country_code,
                :begin_date, :end_date, :reports_to_chart_code, :reports_to_org_code, :active,
                :plant_chart, :plant_account_number, :campus_plant_chart_code, :campus_plant_account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:            random_alphanums(40, 'AFT'),
        chart_code:             'IT', #TODO grab this from config file
        org_code:               random_alphanums(4),
        name:                   random_alphanums(10, 'AFT'),
        manager_principal_name: 'ccs1', #TODO grab this from config file
        resp_center_code:       'NA',
        physcal_campus_code:    'IT', #TODO grab this from config file
        type_code:              'D - Department', #TODO grab this from config file
        address_line_1:         '120 Maple Ave', #TODO grab this from config file
        address_line_2:         'Cornell University', #TODO grab this from config file
        postal_code:            '14850', #TODO grab this from config file
        country_code:           'United States',
        begin_date:             '01/01/2010',
        reports_to_chart_code:  'IT', #TODO grab this from config file
        reports_to_org_code:    '01Y9', #TODO grab this from config file
        plant_chart:            'IT', #TODO grab this from config file
        plant_account_number:   '1000710', #TODO grab this from config file
        campus_plant_chart_code:'IT', #TODO grab this from config file
        campus_plant_account_number: '1000710', #TODO grab this from config file
        press:                       :save
    }
    set_options(defaults.merge(opts))
  end

  def create
    pre_create

    visit(MainPage).organization
    on(OrganizationLookupPage).create
    on OrganizationPage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :org_code, :name, :manager_principal_name, :resp_center_code,
                     :physcal_campus_code, :type_code,
                     :address_line_1, :address_line_2, :postal_code, :country_code,
                     :begin_date, :reports_to_chart_code, :reports_to_org_code
      fill_out_extended_attributes

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press)
    end

    post_create
  end

  def save
    on(OrganizationPage).save
  end

  def submit
    on(OrganizationPage).submit
  end

  def blanket_approve
    on(OrganizationPage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(OrganizationPage).copy
  end
end