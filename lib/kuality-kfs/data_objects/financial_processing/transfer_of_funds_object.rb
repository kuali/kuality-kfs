class TransferOfFundsObject < FinancialProcessingObject

  DOC_INFO = { label: 'Transfer of Funds Document', type_code: 'TF' }

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        #        accounting_lines:     collection('AccountingLines')
        accounting_lines: [
            # Dangerously close to needing to be a Data Object proper...
            { new_account_number: '1258322', #TODO get from config
              new_account_object_code: '4420', #TODO get from config
              new_account_amount: '100'
            }
        ],
        press: :save
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).transfer_of_funds
    on TransferOfFundsPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description
      unless @@skip_default_accounting_lines
        accounting_lines.each do |dep|
          page.from_account_number.fit dep[:new_account_number]
          page.from_object_code.fit dep[:new_account_object_code]
          page.from_amount.fit dep[:new_account_amount]
          page.add_from_accounting_line
        end
      end
#      page.accounting_lines_for_capitalization_select(0).select
#      page.modify_asset
    end
  end

  def view
    @browser.goto "#{$base_url}financialAdvanceDeposit.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #https://cynergy-ci.kuali.cornell.edu/cynergy/kew/DocHandler.do?command=displayDocSearchView&docId=4257342
  end

end #class
