class JournalVoucherObject < KFSDataObject

  DOC_INFO = { label: 'Journal Voucher Document', type_code: 'JV' }

  include VoucherLinesMixin
  alias add_target_line add_source_line

  attr_accessor :organization_document_number, :explanation,
                :accounting_period,
                :balance_type_code, :reversal_date
                # TODO: Create a "line object" for Payment Information and add that to DV.

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_lines)

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).journal_voucher
    on JournalVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation,
                     :accounting_period, :balance_type_code, :reversal_date
    end
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      search.open_doc @document_id
    end
  end

end