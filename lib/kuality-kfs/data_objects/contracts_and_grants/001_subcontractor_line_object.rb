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
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    puts 'header ', on(KFSBasePage).doc_title
    on page_class_for (on(KFSBasePage).doc_title) do |pp|
      pp.new_subcontractor_number.fit           @subcontractor_number
      pp.new_subcontractor_description.fit      @subcontractor_description
      pp.new_subcontractor_amount.fit           @subcontractor_amount
      pp.new_subcontractor_active_indicator.fit @active
      fill_out_extended_attributes
      pp.add_new_subcontractor
    end
  end

  def edit(opts={})
    on page_class_for (on(KFSBasePage).doc_title) do |cgp|
      raise ArgumentError, 'Subcontractor Number cannot be updated!' unless opts[:subcontractor_number].nil?
      cgp.update_subcontractor_description(@line_number).fit      opts[:subcontractor_description]
      cgp.update_subcontractor_amount(@line_number).fit           opts[:subcontractor_amount]
      cgp.update_subcontractor_active_indicator(@line_number).fit opts[:active]
    end
    update_options(opts)
  end

  def delete
    on(page_class_for(on(KFSBasePage).doc_title)).delete_subcontractor @line_number
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
    on page_class_for (on(KFSBasePage).doc_title) do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
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

    on page_class_for (on(KFSBasePage).doc_title) do |cgp|
      case target
        when :old
          pulled_subcontractor = {
              subcontractor_number:           cgp.old_subcontractor_number(i),
              subcontractor_description:      cgp.old_subcontractor_description(i),
              subcontractor_amount:           cgp.old_subcontractor_amount,
              active:                         yesno2setclear(cgp.old_subcontractor_active_indicator(i))
          }
        when :new
          pulled_subcontractor = {
              subcontractor_number:           cgp.update_subcontractor_number(i).text.strip,
              subcontractor_description:      cgp.update_subcontractor_description(i).value.strip,
              subcontractor_amount:           cgp.update_subcontractor_amount.value.strip,
              active:                         yesno2setclear(cgp.update_subcontractor_active_indicator(i).value.strip)
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

