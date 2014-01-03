class AccountDelegateModelObject < DataObject

#  include Navigation
#  include DateFactory
  include StringFactory

  attr_accessor   :chart_of_accounts_code, :organization_code, :adm_name,
                  :active_indicator_yes, :active_indicator_no, :active_indicator_both

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        #chart_of_accounts_code: 'IT', organization_code: '0100', adm_name: '0100 MOD 1'
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).account_delegate_model
    on AccountDelegateModelPage do |create|
       fill_out create,  :chart_of_accounts_code, :organization_code, :adm_name
    end
  end

end #class
