class AdvanceDepositObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Award Budget Document', type_code: 'AD' }

  attr_accessor :advance_deposits,
                :accounting_lines_for_capitalization, :capital_assets, :general_ledger_pending_entries

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        advance_deposits: [
            # Dangerously close to needing to be a Data Object proper...
            { new_deposit_date: '01/01/2014',
              new_deposit_ref_number: random_alphanums(10, 'AFT-AD'),
              new_deposit_description: random_alphanums(40, 'AFT-AD '),
              new_deposit_amount: '100' }
    ]}.merge!(default_lines(initial_lines: [{
                                              account_number: '1258322', #TODO get from config
                                              object_code: '4420', #TODO get from config
                                              amount: '100'
                                            }]))
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).advance_deposit
    on AdvanceDepositPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description
      advance_deposits.each do |dep|
        page.advance_deposit_date.fit dep[:new_deposit_date]
        page.advance_deposit_reference_number.fit dep[:new_deposit_ref_number]
        page.advance_deposit_description.fit dep[:new_deposit_description]
        page.advance_deposit_amount.fit dep[:new_deposit_amount]
        page.add_an_advance_deposit
      end
#      page.accounting_lines_for_capitalization_select(0).select
#      page.modify_asset
    end
  end

  def view
    @browser.goto "#{$base_url}financialAdvanceDeposit.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  # The next few lines override the normal add_line operations to map
  # them to the single accounting line type on this document.
  def add_source_line(al)
    @accounting_lines[:source].add(al.merge({type: :source}))
  end
  alias :add_line :add_source_line
  alias :add_target_line :add_source_line

end