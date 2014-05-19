class SubAccountObject < KFSDataObject

  attr_accessor :chart_code, :account_number, :sub_account_number, :name, :active, :type_code, :icr_identifier,
                :cost_sharing_account_number, :cost_sharing_chart_of_accounts_code,
                :adhoc_approver_userid, :sub_account_type_code, :cost_sharing_account_number

#add if needed                :fin_reporting_chart_code, :fin_reporting_org_code, :fin_reporting_code,

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        account_number:       get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNT_NUMBER),
        sub_account_number:   random_alphanums(7),
        name:                 random_alphanums(10),
        press:                :save
    }
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_SUB_ACCOUNT)).merge(opts))
  end

  def build
    visit(MainPage).sub_account
    on(SubAccountLookupPage).create
    on SubAccountPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :chart_code, :account_number, :sub_account_number, :name,
               :cost_sharing_account_number, :cost_sharing_chart_of_accounts_code,
               :sub_account_type_code, :cost_sharing_account_number

      add_adhoc_approver(page) unless @adhoc_approver_userid.nil?
    end
  end

  def add_adhoc_approver(page)
    page.expand_all
    page.ad_hoc_person.fit @adhoc_approver_userid
    page.ad_hoc_person_add
  end
end