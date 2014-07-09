class AssetManualPaymentObject < KFSDataObject

  include AccountingLinesMixin

  attr_accessor :posted_date, :asset_number, :account_number, :object_code, :asset_number, :amount, :asset_allocation, :object

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),
                 asset_allocation: 'Distribute cost by amount'
               }.merge!(default_accounting_lines)
    set_options(defaults.merge(opts))
  end

  def build
    # TODO : Do not need to open a new page for QA-997.  Just needs an instance of this object.  Need to see if there is a better way to handle this
    if !on(KFSBasePage).header_title.include?('Asset Manual Payment')
      visit(MainPage).asset_manual_payment
      on AssetManualPaymentPage do |page|
        page.description.focus
        page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

        fill_out page, :description, :asset_allocation
        #TODO: Create accounting lines for Cap Assets with extra fields
        # PO# REQ#, origin, doc.number, doc type, posted date


        #NOTE: Object Code looking for subtype from CAPITAL_OBJECT_SUB_TYPES of
        #BK, AC, BE, CM, CF, CV, CT, BD, BF, CS, LA, IM, CL, UC, UF

        #NOTE: while manually testing there was a yes/no page after submit with the data used

      end
    end
  end

end #class