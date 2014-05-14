class SearchAliasLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

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
    on(VendorPage).update_search_alias_active(@line_number).fit opts[:active]
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

  def update_from_page!(target=:new)
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_search_alias_count.zero?
        (0..(lines.current_search_alias_count - 1)).to_a.collect!{ |i|
          pull_existing_search_alias(i, target).merge(pull_extended_existing_search_alias(i, target))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which search alias to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_search_alias(i=0, target=:new)
    pulled_search_alias = Hash.new

    on VendorPage do |vp|
      case target
        when :old
          pulled_search_alias = {
            name:   vp.old_search_alias_name(i),
            active: yesno2setclear(vp.old_search_alias_active(i))
          }
        when :new
          pulled_search_alias = {
            name:   vp.update_search_alias_name(i),
            active: yesno2setclear(vp.update_search_alias_active(i))
          }
      end
    end

    pulled_search_alias
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which search alias to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_search_alias(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end