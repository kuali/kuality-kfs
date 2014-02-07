class NonCheckDisbursementObject < FinancialProcessingObject

  DOC_INFO = { label: 'Non Check Disbusement', type_code: 'ND' }

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        #        accounting_lines:     collection('AccountingLines')
        accounting_lines: [
            # Dangerously close to needing to be a Data Object proper...
            { account_number: 'G003704', #TODO get from config
              object_code: '6540', #TODO get from config
              amount: '100', reference_number: '1234'
            }
        ], add_accounting_line: true,
        press: :save
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).non_check_disbursement
    on NonCheckDisbursementPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description
      if  add_accounting_line == true
        accounting_lines.each do |dep|
          page.account_number.fit dep[:account_number]
          page.object_code.fit dep[:object_code]
          page.amount.fit dep[:amount]
          page.reference_number.fit dep[:reference_number]

          page.add_accounting_line
        end
      end
#      page.accounting_lines_for_capitalization_select(0).select
#      page.modify_asset
    end
  end

  def view
    @browser.goto "#{$base_url}financialNonCheckDisbursement.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #https://cynergy-ci.kuali.cornell.edu/cynergy/kew/DocHandler.do?command=displayDocSearchView&docId=4257342
  end

end #class
