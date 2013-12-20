class AccountDelegateModelObject < DataObject

#  include Navigation
#  include DateFactory
  include StringFactory

  attr_accessor :chart_code, :org_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                :approval_to_this_account, :account_delegate_principal_name, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                          random_alphanums(40, 'AFT'),
        chart_code:                           'IT', #TODO grab this from config file
        org_code:                             '01G0',
        account_delegate_model_name:          '', #FIXME Find default value for Account Delegate Model Name
        document_type_name:                   '', #FIXME Find default value for Document Type Name
        account_delegate_start_date:          '01/01/2010',
        account_delegate_principal_name:      '' #FIXME Find default value for Account Delegate Principle Name
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).account
    on(AccountDelegateModelLookupPage).create
    on AccountDelegateModelPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :chart_code, :org_code, :account_delegate_model_name, :active_indicator, :document_type_name,
                     :account_delegate_primary_route, :account_delegate_start_date, :approval_from_this_account,
                     :approval_to_this_account, :account_delegate_principal_name, :active
      page.save
      @document_id = page.document_id
    end
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