class AwardAccountLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :chart_code, :account_number, :principal_name, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    on AwardPage do |ap|
      ap.new_account_chart_code.fit                             @chart_code
      ap.new_account_number.fit                                 @account_number
      ap.new_account_project_director_principal_name.fit        @principal_name
      ap.new_account_active_indicator.fit                       @active
      fill_out_extended_attributes
      ap.add_new_account
    end
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def edit_attributes(opts = {})
    on AwardPage do |ap|
      raise ArgumentError, 'Chart Code cannot be updated!' unless opts[:chart_code].nil?
      raise ArgumentError, 'Account Number cannot be updated!' unless opts[:account_number].nil?
      ap.update_account_project_director_principal_name(@line_number).fit   opts[:principal_name]
      ap.update_account_active_indicator(@line_number).fit                  opts[:active]
    end
    update_options(opts)
  end

  def delete
    on(AwardPage).delete_account @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class AwardAccountLineObjectCollection < LineObjectCollection

  contains AwardAccountLineObject

  def update_from_page!(target=:new)
    on AwardPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_account_count.zero?
        (0..(lines.current_account_count - 1)).to_a.collect!{ |i|
          pull_existing_award_account(i, target).merge(pull_extended_existing_award_account(i, target))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_award_account(i=0, target=:new)
    pulled_award_account = Hash.new

    on AwardPage do |ap|
      case target
        when :old
          pulled_award_account = {
              chart_code:           ap.old_account_chart_code(i),
              account_number:       ap.old_account_number(i),
              principal_name:       ap.old_account_project_director_principal_name(i),
              active:               yesno2setclear(ap.old_account_active_indicator(i))
          }
        when :new
          pulled_award_account = {
              chart_code:           ap.update_account_chart_code(i).text.strip,
              account_number:       ap.update_account_number(i).text.strip,
              principal_name:       ap.update_account_project_director_principal_name(i).value.strip,
              active:               yesno2setclear(ap.update_account_active_indicator(i).value)
          }
      end
    end

    pulled_award_account
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_award_account(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

