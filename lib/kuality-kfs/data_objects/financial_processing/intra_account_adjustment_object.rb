class IntraAccountAdjustmentObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Intra Account Adjustment Document', type_code: 'IAA', transactional?: true }

  attr_accessor :organization_document_number, :explanation

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description: random_alphanums(40, 'AFT') }.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_INTRA_ACCOUNT_ADJUSTMENT)).merge(opts))
  end

  def build
    visit(MainPage).intra_account_adjustment
    on IntraAccountAdjustmentPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

  def default_accounting_lines(opts={})
    super(opts).merge(
      initial_lines: [{
                          account_number: get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNTING_LINE_ACCOUNT_NUMBER),
                          object: get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNTING_LINE_OBJECT_CODE),
                          amount: '100'
                      }])
  end

end
