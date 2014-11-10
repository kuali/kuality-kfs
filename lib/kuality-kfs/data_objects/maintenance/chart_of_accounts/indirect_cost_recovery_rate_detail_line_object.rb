class IndirectCostRecoveryRateDetailLineObject < DataFactory

  attr_accessor :line_number, :chart_code, :account_number, :sub_account_number,
                :object_code, :sub_object_code, :debit_credit_code, :percent, :details_active_indicator


  # Class Constants
  DEBIT_WILDCARD  = '@'
  CREDIT_WILDCARD = '#'


  def initialize(browser, opts={})
    @browser = browser

    defaults = { details_active_indicator: :set }

    set_options(defaults.merge(opts))
  end


  def create
      on IndirectCostRecoveryRatePage do |page|
        fill_out page, :chart_code, :account_number, :sub_account_number, :object_code, :sub_object_code, :debit_credit_code, :percent
        fill_out_extended_attributes
        page.add_icr_rate_detail
      end

  end


  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end
end


class IndirectCostRecoveryRateDetailLineObjectCollection < LineObjectCollection

  contains IndirectCostRecoveryRateDetailLineObject

  def update_from_page!(target=:new)
    on IndirectCostRecoveryRatePage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_icr_rate_detail_count.zero?
        (0..(lines.current_icr_rate_detail_count - 1)).to_a.collect!{ |i|
          pull_existing_detail(i, target).merge(pull_extended_existing_detail(i, target))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contact to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_detail(i=0, target=:new)
    pulled_detail = Hash.new

    on IndirectCostRecoveryRatePage do |page|
      case target
        when :new
          pulled_detail = {
              line_number:                page.line_number_new(i),
              chart_code:                 page.chart_code_new(i),
              account_number:             page.account_number_new(i),
              sub_account_number:         page.sub_account_number_new(i),
              object_code:                page.object_code_new(i),
              sub_object_code:            page.sub_object_code_new(i),
              debit_credit_code:          page.debit_credit_code_new(i),
              percent:                    page.percent_new(i),
              details_active_indicator:   page.details_active_indicator_new(i)
          }
      end
    end

    pulled_detail
  end


  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contact to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_detail(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end