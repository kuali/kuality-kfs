class SubcontractorLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :subcontractor_number, :subcontractor_description, :subcontractor_amount, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    on SubcontractorsTab do |tab|
      tab.new_subcontractor_number.fit           @subcontractor_number
      tab.new_subcontractor_description.fit      @subcontractor_description
      tab.new_subcontractor_amount.fit           @subcontractor_amount
      tab.new_subcontractor_active_indicator.fit @active
      fill_out_extended_attributes
      tab.add_new_subcontractor
    end
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def edit_attributes(opts = {})
    on SubcontractorsTab do |tab|
      raise ArgumentError, 'Subcontractor Number cannot be updated!' unless opts[:subcontractor_number].nil?
      tab.update_subcontractor_description(@line_number).fit      opts[:subcontractor_description]
      tab.update_subcontractor_amount(@line_number).fit           opts[:subcontractor_amount]
      tab.update_subcontractor_active_indicator(@line_number).fit opts[:active]
    end
    update_options(tab)
  end


  def delete
    on(SubcontractorsTab).delete_subcontractor @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class SubcontractorLineObjectCollection < LineObjectCollection

  contains SubcontractorLineObject

  def update_from_page!(target=:new)
    on SubcontractorsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_subcontractor_count.zero?
        (0..(lines.current_subcontractor_count - 1)).to_a.collect!{ |i|
          pull_existing_subcontractor(i, target).merge(pull_extended_existing_subcontractor(i, target))
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
  def pull_existing_subcontractor(i=0, target=:new)
    pulled_subcontractor = Hash.new

    on SubcontractorsTab do |tab|
      case target
        when :old
          pulled_subcontractor = {
              subcontractor_number:           tab.old_subcontractor_number(i),
              subcontractor_description:      tab.old_subcontractor_description(i),
              subcontractor_amount:           tab.old_subcontractor_amount,
              active:                         yesno2setclear(tab.old_subcontractor_active_indicator(i))
          }
        when :new
          pulled_subcontractor = {
              subcontractor_number:           tab.update_subcontractor_number(i).text.strip,
              subcontractor_description:      tab.update_subcontractor_description(i).value.strip,
              subcontractor_amount:           tab.update_subcontractor_amount.value.strip,
              active:                         yesno2setclear(tab.update_subcontractor_active_indicator(i).value.strip)
          }
      end
    end

    pulled_subcontractor
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_subcontractor(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

