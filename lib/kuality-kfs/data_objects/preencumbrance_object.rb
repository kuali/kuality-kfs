class PreEncumbranceObject < DataObject

#  include Navigation
#  include DateFactory
  include StringFactory

  attr_accessor   :reversal_date, :chart_code, :account_number, :sub_account, :object, :sub_object,
                  :project, :org_ref_id, :line_description, :amount, :auto_disencumber_type,
                  :start_date, :count, :partial_amount, :press

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           'IT', #TODO grab this from config file
        account_number:       random_alphanums(7),
        object:               '6100',
        amount:               '0.01'
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit PreEncumbrancePage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :reversal_date, :chart_code, :account_number, :sub_account, :object, :sub_object,
                     :project, :org_ref_id, :line_description, :amount, :auto_disencumber_type,
                     :start_date, :count, :partial_amount

      page.add_encumbrance
      @document_id = page.document_id

      case press
        when PreEncumbrancePage::SAVE
          page.save
        when PreEncumbrancePage::SUBMIT
          page.submit
        when PreEncumbrancePage::BLANKET_APPROVE
          page.blanket_approve
        else
          page.save
      end
    end
  end

  def save
    on(PreEncumbrancePage).save
  end

  def submit
    on(PreEncumbrancePage).submit
  end

  def blanket_approve
    on(PreEncumbrancePage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}portal.do?channelTitle=Open%20Encumbrances&channelUrl=glModifiedInquiry.do?" <<
                  "methodToCall=start&businessObjectClassName=org.kuali.kfs.gl.businessobject.Encumbrance&" <<
                  "docFormKey=88888888&returnLocation=portal.do&hideReturnLink=true"
    on OpenEncumbranceLookupPage do
      
    end
  end
end