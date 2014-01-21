class AccountDelegateGlobalExtendedAttributesObject < DataObject
  # This super-class provides an overridable target for institutions to
  # inject extended attributes into an AccountGlobalObject. Please provide the
  # overrides in your institution's project.
end

class AccountDelegateGlobalObject < AccountDelegateGlobalExtendedAttributesObject

#  include Navigation
#  include DateFactory
  include StringFactory


  attr_accessor :description, :doc_type, :primary_route, :start_date, :principal_name, :chart_code, :account_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums(20, 'AFT'),
        doc_type:       'KFST',
        principal_name: 'dh273', #TODO paramter
        chart_code:     'IT - Ithaca Campus', #TODO paramter
        account_number: '1000710' #TODO paramter
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).account_delegate_global

    on AccountDelegateGlobalPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :doc_type, :principal_name
#      super # For now, overriding the super#create should only do what is required to fill out extended attributes
      page.add_delegate

      fill_out page, :chart_code, :account_number
      page.add_account

      page.save
      @document_id = page.document_id
    end
  end

  def save
    on(AccountDelegateGlobalPage).save
  end

  def submit
    on(AccountDelegateGlobalPage).submit
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  #def add_multiple_accounting_lines
  #  if !@add_multiple_accounting_lines.nil?
  #    on(AccountGlobalPage).add_multiple_accounting_lines
  #    on AccountGlobalLookupPage do |page|
  #      page.account_number.fit @search_account_number
  #      page.search
  #      page.select_all_rows_from_this_page
  #      page.return_selected_results
  #    end
  #  end
  #end
end