class AuxiliaryVoucherObject < FinancialProcessingObject

  DOC_INFO = { label: 'Auxiliary Voucher Document', type_code: 'AV' }

  attr_accessor   :add_accounting_line


  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        #        accounting_lines:     collection('AccountingLines')
        accounting_lines: [
            # Dangerously close to needing to be a Data Object proper...
            { new_account_number: '1258322', #TODO get from config
              new_account_object_code: '4420', #TODO get from config
              new_account_amount: '100', add_accounting_line: true
            }
        ],
        press: :save
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).auxiliary_voucher
    on AuxiliaryVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description


          accounting_lines.each do |dep|
          page.account_number.fit dep[:new_account_number]
          page.object_code.fit dep[:new_account_object_code]
          page.debit.fit dep[:new_account_amount]
          page.add_accounting_line unless @add_accounting_line == false
        end
#      page.accounting_lines_for_capitalization_select(0).select
#      page.modify_asset
    end
  end

  def view
    @browser.goto "#{$base_url}/financialAuxiliaryVoucher.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView#topOfForm"
  end

end #class
