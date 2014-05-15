class AssetManualPaymentObject < KFSDataObject

  attr_accessor :posted_date, :asset_number, :account_number, :object_code, :asset_number, :amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT')
    # account_number: '1000710',
    # object_code: '3610',
    # asset_number: '3150',
    # amount: '100',
    # posted_date: '05/15/2014'

    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).asset_manual_payment
    on AssetManualPaymentPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description
      #Has Accounting lines with extra fields
      # PO# REQ#, origin, doc.number, doc type, posted date

      #looking for object code from subtype CAPITAL_OBJECT_SUB_TYPES of
      #BK, AC, BE, CM, CF, CV, CT, BD, BF, CS, LA, IM, CL, UC, UF

      #Select Yes

    end
  end


end #class