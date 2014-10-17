class IndirectCostRecoveryLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :chart_of_accounts_code,
                  :account_number,
                  :account_line_percent,
                  :active_indicator

  def defaults
    Hash.new
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(opts))
  end

  # @return [Hash] Hash that can be used for serialization
  def to_update
    Hash[self.class.attributes.zip(self.class.attributes.collect { |attr| (self.send(attr)) })]
  end

  def create
    on IndirectCostRecoveryAccountsTab do |icr_tab|
      fill_out icr_tab, :chart_of_accounts_code, :account_number, :account_line_percent, :active_indicator
      fill_out_extended_attributes
      icr_tab.add_icr_account
    end
  end

  def edit(opts={})
    on IndirectCostRecoveryAccountsTab do |icr_tab|
      icr_tab.update_chart_of_accounts_code(@line_number).pick! opts[:chart_of_accounts_code] unless opts[:chart_of_accounts_code].nil?
      icr_tab.update_account_number(@line_number).fit           opts[:account_number] unless opts[:account_number].nil?
      icr_tab.update_account_line_percent(@line_number).fit     opts[:account_line_percent] unless opts[:account_line_percent].nil?
      icr_tab.update_active_indicator(@line_number).fit         opts[:active_indicator] unless opts[:active_indicator].nil?
    end
    update_options(opts)
    update_extended_attributes(opts)
  end

  def delete
    on(IndirectCostRecoveryAccountsTab).delete_icr_account
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class IndirectCostRecoveryLineObjectCollection < LineObjectCollection

  contains IndirectCostRecoveryLineObject


  # @return [Array] Ordered Array of Hashes that can be used for serialization
  def to_update
    {
        icr_accounts: collect { |icra| icra.to_update }
    }
  end

  # @param [Symbol] target Which ICR Account to pull from (most useful during a copy action). Defaults to :new
  def update_from_page!(target=:new)
    clear # Drop any cached lines. More reliable than sorting out an array merge.

    updates = updates_pulled_from_page(target)
    unless updates.nil?
      updates.each do |new_obj|
        # Update the stored lines
        self << (make contained_class, new_obj)
      end
    end
  end

  # @param [Symbol] target Which ICR Account to pull from (most useful during a copy action). Defaults to :new
  # @return [Array] Array of Hashes representing the updates that were pulled, or nil if none were found.
  def updates_pulled_from_page(target=:new)
    on IndirectCostRecoveryAccountsTab do |icra_tab|
      icra_tab.show_icr_accounts unless icra_tab.icra_tab_shown?
      if icra_tab.current_icr_accounts_count.zero?
        return nil
      else
        return (0..(icra_tab.current_icr_accounts_count - 1)).to_a
                                                             .collect!{ |i|
          {line_number: i}.merge(pull_existing_icr_account(i, target))
                          .merge(pull_extended_existing_icr_account(i, target))
        }
      end
    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which ICR Account to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_icr_account(i=0, target=:new)
    pulled_icr_account = Hash.new

    on IndirectCostRecoveryAccountsTab do |icr_tab|
      case target
        when :old, :new
          # How fancy is this!?!
          pulled_icr_account = {
            chart_of_accounts_code: icr_tab.send("#{target}_chart_of_accounts_code", i),
            account_number:         icr_tab.send("#{target}_account_number", i),
            account_line_percent:   icr_tab.send("#{target}_account_line_percent", i),
            active_indicator:       icr_tab.send("#{target}_active_indicator", i),
          }
        else
          raise ArgumentError, "IndirectCostRecoveryLineObject does not know how to pull the provided ICR Account type (#{target})!"
      end
    end

    pulled_icr_account
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_icr_account(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

  def account_line_percent_sum
    reduce(0) { |sum, icra| sum + icra.account_line_percent.to_i }
  end

end