class AccountDelegateGlobalObject < KFSDataObject

  attr_accessor :doc_type, :primary_route, :start_date,
                :principal_name, :chart_code, :account_number

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
    pre_create

    visit(MainPage).account_delegate_global

    on AccountDelegateGlobalPage do |page|
      @document_id = page.document_id
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :doc_type, :principal_name
      fill_out_extended_attributes(:delegate)
      page.add_delegate

      fill_out page, :chart_code, :account_number
      fill_out_extended_attributes(:account)

      page.add_account

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press) unless @press.nil?
    end

    post_create
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