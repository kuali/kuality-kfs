class AccountDelegateObject < KFSDataObject

  attr_accessor :chart_code, :number, :doc_type_name, :principal_name,
                :approval_from_amount, :approval_to_amount, :primary_route, :active, :start_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description:          random_alphanums(40, 'AFT'),
      chart_code:           'IT', #TODO grab this from config file
      number:               random_alphanums(7),
      doc_type_name:        'IB',
      principal_name:       'dh273', #TODO config this
      start_date:           '01/01/2014',
      press:                :save
    }
    set_options(defaults.merge(opts))
  end

  def create
    pre_create

    visit(MainPage).account_delegate
    on(AccountDelegateLookupPage).create
    on AccountDelegatePage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :number, :doc_type_name, :principal_name, :start_date
      fill_out_extended_attributes

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press)
    end

    post_create
  end

  def save
    on(AccountDelegatePage).save
  end

  def submit
    on(AccountDelegatePage).submit
  end

  def blanket_approve
    on(AccountDelegatePage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(AccountDelegatePage).copy
  end

end