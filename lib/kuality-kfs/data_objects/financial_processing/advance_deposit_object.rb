class AdvanceDepositObject < DataObject

#  include Navigation
#  include DateFactory
  include StringFactory

  attr_accessor :description, :advance_deposits, :accounting_lines,
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
        ],
#        accounting_lines:     collection('AccountingLines')
        accounting_lines: [
            # Dangerously close to needing to be a Data Object proper...
            { new_account_number: '1258322', #TODO get from config
              new_account_object_code: '4420', #TODO get from config
              new_account_amount: '100'
            }
        ],
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).advance_deposit
    on AdvanceDepositPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description
      advance_deposits.each do |dep|
        page.new_deposit_date.fit dep[:new_deposit_date]
        page.new_deposit_ref_number.fit dep[:new_deposit_ref_number]
        page.new_deposit_description.fit dep[:new_deposit_description]
        page.new_deposit_amount.fit dep[:new_deposit_amount]
        page.add_deposit
      end
      accounting_lines.each do |dep|
        page.new_account_number.fit dep[:new_account_number]
        page.new_account_object_code.fit dep[:new_account_object_code]
        page.new_account_amount.fit dep[:new_account_amount]
        page.add_accounting_line
      end
#      page.accounting_lines_for_capitalization_select(0).select
#      page.modify_asset
      page.save
      @document_id = page.document_id
    end
  end

  def save
    on(AdvanceDepositPage).save
  end

  def submit
    on(AdvanceDepositPage).submit
  end

  def blanket_approve
    on(AdvanceDepositPage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}financialAdvanceDeposit.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(AdvanceDepositPage).copy
  end
end