class AccountDelegateModelObject < KFSDataObject

  attr_accessor :chart_of_accounts_code, :organization_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                :approval_to_this_account, :account_delegate_principal_name, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description:                          random_alphanums(40, 'AFT'),
      chart_of_accounts_code:               get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
      organization_code:                    '0100',       #TODO replace with bootstrap data
      account_delegate_model_name:          random_alphanums(40, 'AFT'),
      document_type_name:                   'IB',
      account_delegate_start_date:          '01/01/2010', #TODO replace with bootstrap data
      account_delegate_principal_name:      'JMD11',      #TODO replace with bootstrap data
      active_indicator:                     :set,
      active:                               :set
    }
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ACCOUNT_DELEGATE_MODEL)).merge(opts))
  end

  def build
    visit(MainPage).account_delegate_model
    on(AccountDelegateModelLookupPage).create
    on AccountDelegateModelPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_of_accounts_code, :organization_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                     :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                     :approval_to_this_account, :account_delegate_principal_name, :active
    end
  end

end
