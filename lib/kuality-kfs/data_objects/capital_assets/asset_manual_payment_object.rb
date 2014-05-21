class AssetManualPaymentObject < KFSDataObject

  attr_accessor :posted_date, :asset_number, :account_number, :object_code, :asset_number, :amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT') }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).asset_manual_payment
    on AssetManualPaymentPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description
      #TODO: Create accounting lines for Cap Assets with extra fields
      # PO# REQ#, origin, doc.number, doc type, posted date


      #NOTE: Object Code looking for subtype from CAPITAL_OBJECT_SUB_TYPES of
      #BK, AC, BE, CM, CF, CV, CT, BD, BF, CS, LA, IM, CL, UC, UF

      #NOTE: while manually testing there was a yes/no page after submit with the data used

    end
  end


end #class