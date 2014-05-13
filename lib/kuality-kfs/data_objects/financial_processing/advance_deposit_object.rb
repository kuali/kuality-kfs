class AdvanceDepositObject < KFSDataObject

  include AccountingLinesMixin

  DOC_INFO = { label: 'Award Budget Document', type_code: 'AD' }

  attr_accessor :advance_deposits,
                :accounting_lines_for_capitalization, :capital_assets, :general_ledger_pending_entries

  def default_accounting_lines(opts={})
    super(opts).merge(
    initial_lines: [{
                      account_number: get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNTING_LINE_ACCOUNT_NUMBER),
                      object: get_aft_parameter_value(ParameterConstants::DEFAULT_ACCOUNTING_LINE_OBJECT_CODE),
                      amount: '100'
                    }])
  end

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
    ]}.merge!(default_accounting_lines)

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ADVANCE_DEPOSIT)).merge(opts))
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

  # The next few lines override the normal add_line operations to map
  # them to the single accounting line type on this document.
  alias :add_target_line :add_source_line

end