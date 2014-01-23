class AccountDelegateModelObject < KFSDataObject

  attr_accessor :chart_of_accounts_code, :organization_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                :approval_to_this_account, :account_delegate_principal_name, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description:                          random_alphanums(40, 'AFT'),
      chart_of_accounts_code:               'IT', #TODO grab this from config file
      organization_code:                    '0100',
      account_delegate_model_name:          random_alphanums(40, 'AFT'),
      document_type_name:                   'IB',
      account_delegate_start_date:          '01/01/2010',
      account_delegate_principal_name:      'JMD11',
      active_indicator:                     :set,
      active:                               :set
    }
    set_options(defaults.merge(opts))
  end

  def create
    pre_create

    visit(MainPage).account_delegate_model
    on(AccountDelegateModelLookupPage).create
    on AccountDelegateModelPage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_of_accounts_code, :organization_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                     :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                     :approval_to_this_account, :account_delegate_principal_name, :active
      fill_out_extended_attributes

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press) unless @press.nil?
    end

    post_create
  end

  def save
    on(AccountDelegateModelPage).save
  end

  def submit
    on(AccountDelegateModelPage).submit
  end

  def blanket_approve
    on(AccountDelegateModelPage).blanket_approve
  end

  def view
    # TODO: AccountDelegateModelObject#view
    #@browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(AccountDelegateModelPage).copy
  end
end
