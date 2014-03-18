class JournalVoucherObject < KFSDataObject

  include VoucherLinesMixin
  alias add_target_line add_source_line

  DOC_INFO = { label: 'Journal Voucher Document', type_code: 'JV' }

  attr_accessor :organization_document_number, :explanation,
                :accounting_period,
                :balance_type_code, :reversal_date
                # TODO: Create a "line object" for Payment Information and add that to DV.

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).journal_voucher
    on JournalVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

end