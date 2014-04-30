class SearchAliasLineObject < DataFactory

  include DateFactory
  include StringFactory

  attr_accessor   :line_number,
                  :name, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { name: random_alphanums(40, 'AFT'), active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    on VendorPage do |vp|
      vp.new_search_alias_name.fit   @name
      vp.new_search_alias_active.fit @active
      fill_out_extended_attributes
      vp.add_search_alias
    end
  end

  def edit(opts={})
    raise ArgumentError, 'Search Alias Names cannot be updated, only deleted!' unless opts[:name].nil?
    on(VendorPage).search_alias_active(@line_number).fit opts[:active] unless opts[:active].nil?
    update_options(opts)
  end

  def delete
    on(VendorPage).delete_search_alias @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class SearchAliasLineObjectCollection < LineObjectCollection

  contains SearchAliasLineObject

  def update_from_page!
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_search_alias_count.zero?
        (0..(lines.current_search_alias_count - 1)).to_a.collect!{ |i|
          lines.pull_existing_search_alias(i).merge(pull_extended_existing_search_alias(i))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @return [Hash] The return values of extended attributes for the given line
  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Watir::Browser] b The current browser object
  # @return [Hash] The known line values
  def pull_extended_existing_search_alias(i=0)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end