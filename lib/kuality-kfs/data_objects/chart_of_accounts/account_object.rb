class AccountObject < KFSDataObject

  attr_accessor :chart_code, :number, :name, :organization_code, :campus_code, :effective_date,
                :postal_code, :city, :state, :address, :closed,
                :type_code, :sub_fund_group_code, :higher_ed_funct_code, :restricted_status_code,
                :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                :budget_record_level_code, :sufficient_funds_code,
                :expense_guideline_text, :income_guideline_txt, :purpose_text,
                :income_stream_financial_cost_code, :income_stream_account_number, :labor_benefit_rate_cat_code, :account_expiration_date,
                :indirect_cost_recovery_chart_of_accounts_code, :indirect_cost_recovery_account_number, :indirect_cost_recovery_account_line_percent,
                :indirect_cost_recovery_active_indicator

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                       random_alphanums(40, 'AFT'),
        chart_code:                        get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
        number:                            random_alphanums(7),
        name:                              random_alphanums(10),
        organization_code:                 '01G0',  #TODO replace with bootstrap data
        campus_code:                       get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_CODE),
        effective_date:                    '01/01/2010',
        postal_code:                       get_random_postal_code('*'),
        city:                              get_generic_city,
        state:                             get_random_state_code,
        address:                           get_generic_address_1,
        type_code:                         get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_TYPE_CODE),
        sub_fund_group_code:               'ADMSYS', #TODO replace with bootstrap data
        higher_ed_funct_code:              '4000',   #TODO replace with bootstrap data
        restricted_status_code:            'U - Unrestricted',  #TODO replace with bootstrap data
        fo_principal_name:                 get_aft_parameter_value(ParameterConstants::DEFAULT_FISCAL_OFFICER),
        supervisor_principal_name:         get_aft_parameter_value(ParameterConstants::DEFAULT_SUPERVISOR),
        manager_principal_name:            get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER),
        budget_record_level_code:          'C - Consolidation', #TODO replace with bootstrap data
        sufficient_funds_code:             'C - Consolidation', #TODO replace with bootstrap data
        expense_guideline_text:            'expense guideline text',
        income_guideline_txt:              'incomde guideline text',
        purpose_text:                      'purpose text',
        labor_benefit_rate_cat_code:       'CC',    #TODO replace with bootstrap data
        account_expiration_date:           '',
        press:                             :save
    }
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ACCOUNT)).merge(opts))

  end

  def build
    visit(MainPage).account
    on(AccountLookupPage).create
    on AccountPage do |page|
      page.expand_all
      page.type_code.fit @type_code
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :number, :name, :organization_code, :campus_code,
                     :effective_date, :postal_code, :city, :state, :address, :sub_fund_group_code,
                     :higher_ed_funct_code, :restricted_status_code, :fo_principal_name, :supervisor_principal_name,
                     :manager_principal_name, :budget_record_level_code, :sufficient_funds_code, :expense_guideline_text,
                     :income_guideline_txt, :purpose_text, :income_stream_financial_cost_code, :income_stream_account_number,
                     :account_expiration_date, :closed,
                     :indirect_cost_recovery_chart_of_accounts_code, :indirect_cost_recovery_account_number,
                     :indirect_cost_recovery_account_line_percent, :indirect_cost_recovery_active_indicator
    end
  end
end