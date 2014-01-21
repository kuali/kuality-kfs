class SubAccountObject < KFSDataObject

  attr_accessor :chart_code, :account_number, :sub_account_number, :name, :active, :type_code, :icr_identifier
#add if needed                :fin_reporting_chart_code, :fin_reporting_org_code, :fin_reporting_code,

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           'IT', #TODO grab this from config file
        account_number:       '1000710', #TODO need to look this up
        sub_account_number:   random_alphanums(7),
        name:                 random_alphanums(10),
        press:                :save
    }
    set_options(defaults.merge(opts))
  end

  def create
    pre_create

    visit(MainPage).sub_account
    on(SubAccountLookupPage).create
    on SubAccountPage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :account_number, :sub_account_number, :name
      fill_out_extended_attributes

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press)
    end

    post_create
  end

  def save
    on(SubAccountPage).save
  end

  def submit
    on(SubAccountPage).submit
  end

  def blanket_approve
    on(SubAccountPage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(SubAccountPage).copy
  end

  def approve
    on(SubAccountPage).approve
  end
end