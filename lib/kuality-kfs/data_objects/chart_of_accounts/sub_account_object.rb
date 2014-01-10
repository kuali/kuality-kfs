class SubAccountObject < DataObject

  include StringFactory

  attr_accessor :description, :chart_code, :account_number, :sub_account_number, :name, :active, :type_code, :icr_identifier, :press
#add if needed                :fin_reporting_chart_code, :fin_reporting_org_code, :fin_reporting_code,


  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           'IT', #TODO grab this from config file
        account_number:       '0142900', #TODO need to look this up
        sub_account_number:   random_alphanums(7),
        name:                 random_alphanums(10)
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).sub_account
    on(SubAccountLookupPage).create
    on SubAccountPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :account_number, :sub_account_number, :name
      case press
        when SubAccountPage::SAVE
          page.save
        when SubAccountPage::SUBMIT
          page.submit
        when SubAccountPage::BLANKET_APPROVE
          page.blanket_approve
        else
          page.save
      end
      @document_id = page.document_id
    end
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
end