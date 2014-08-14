class NonCheckDisbursementObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Non-Check Disbursement Document', type_code: 'ND', transactional?: true }

  attr_accessor :organization_document_number, :explanation, :bank_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_NON_CHECK_DISBURSEMENT)).merge(opts))
  end

  def build
    visit(MainPage).non_check_disbursement
    on NonCheckDisbursementPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation, :bank_code
    end
  end

end