class AccountObject < KFSDataObject

  attr_accessor :chart_code, :number, :name, :organization_code, :campus_code, :effective_date,
                :postal_code, :city, :state, :address,
                :type_code, :sub_fund_group_code, :higher_ed_funct_code, :restricted_status_code,
                :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                :budget_record_level_code, :sufficient_funds_code,
                :expense_guideline_text, :income_guideline_text, :purpose_text,
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
        organization_code:                          '01G0',
        campus_code:                       'IT - Ithaca', #TODO grab this from config file
        effective_date:                    '01/01/2010',
        postal_code:                       '14853', #TODO grab this from config file
        city:                              'Ithaca', #TODO grab this from config file
        state:                             'NY', #TODO grab this from config file
        address:                           'Cornell University', #TODO grab this from config file
        type_code:                         'CC - Contract College', #TODO grab this from config file
        sub_fund_group_code:                'ADMSYS',
        higher_ed_funct_code:              '4000',
        restricted_status_code:            'U - Unrestricted',
        fo_principal_name:                 'dh273',
        supervisor_principal_name:         'ccs1',
        manager_principal_name:            'aap98',
        budget_record_level_code:          'C - Consolidation',
        sufficient_funds_code:             'C - Consolidation',
        expense_guideline_text:            'expense guideline text',
        income_guideline_text:              'income guideline text',
        purpose_text:                      'purpose text',
        income_stream_financial_cost_code: 'IT - Ithaca Campus',
        income_stream_account_number:      '1000710',
        labor_benefit_rate_cat_code:       'CC',
        account_expiration_date:           '',
        press:                             :save
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).account
    on(AccountLookupPage).create
    on AccountPage do |page|
      page.expand_all
      page.type_code.fit @type_code
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out_required_attributes
      fill_out_optional_attributes
    end
  end

  def fill_out_required_attributes
    super
    on AccountPage do |page|
      fill_out page, :chart_code, :number, :name, :organization_code,
                     :campus_code, :effective_date, :postal_code, :city, :state, :address, :type_code,
                     :sub_fund_group_code, :higher_ed_funct_code, :restricted_status_code,
                     :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                     :budget_record_level_code, :sufficient_funds_code,
                     :expense_guideline_text, :income_guideline_text, :purpose_text
    end
  end

  def fill_out_optional_attributes
    super
    on AccountPage do |page|
      fill_out page, :income_stream_financial_cost_code, :income_stream_account_number,
                     :account_expiration_date,
                     :indirect_cost_recovery_chart_of_accounts_code, :indirect_cost_recovery_account_number,
                     :indirect_cost_recovery_account_line_percent, :indirect_cost_recovery_active_indicator
    end
  end

  def absorb(target={})
    super
    update_options(on(AccountPage).send("#{target.to_s}_account_data"))
  end
end