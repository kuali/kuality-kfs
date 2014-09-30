class CapitalAssetLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number, :manufacturer, :description,
                  :line_amount, :insert_tag, :qty, :type

  def defaults
    default_asset_location_lines.merge({ type: '019'})
  end

  def initialize(browser, opts={})
    @browser = browser

    #defaults = { capital_asset_type: '019' }

    set_options(defaults.merge(opts))
    post_initialize
  end

  def create
    # For now, this only supports DI. We'll need to refactor appropriately
    # if any other object needs this collection.
    # asset line is different the normal Kuali collection.  There is no 'new' line to add.
    if on(CapitalAssetsTab).asset_tables.length > 1
      on CapitalAssetsTab do |tab|
        tab.qty.fit             @qty
        tab.line_amount.fit     @line_amount
        tab.type.fit            @type
        tab.manufacturer.fit    @manufacturer
        tab.description.fit     @description
        fill_out_extended_attributes
      end
    end
  end

  def edit(opts={})
    on CapitalAssetsTab do |tab|
      tab.qty(@line_number).fit           opts[:qty]
      tab.line_amount(@line_number).fit   opts[:line_amount]
      tab.type(@line_number).fit          opts[:type]
      tab.manufacturer(@line_number).fit  opts[:manufacturer]
      tab.description(@line_number).fit   opts[:description]
    end
    update_options(opts)
  end
  def post_initialize; end

  def pre_create; end

  def post_create; end

  def delete
    on(CapitalAssetsTab).delete_asset @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes
  include CapitalAssetLocationLinesMixin

end

class CapitalAssetLineObjectCollection < LineObjectCollection

  contains CapitalAssetLineObject

  def update_from_page!(target=:new)
    on CapitalAssetsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_asset_count.zero?
        (0..(lines.current_asset_count - 1)).to_a.collect!{ |i|
          pull_existing_asset(i, target).merge(pull_extended_existing_asset(i, target))
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
  def pull_existing_asset(i=0, target=:new)
    pulled_asset = Hash.new

    on CapitalAssetsTab do |tab|
      case target
        when :old
          pulled_asset = {
              qty:           tab.old_qty(i),
              type:          tab.old_type(i),
              manufacturer:  tab.old_manufacturer(i),
              line_amount:   tab.old_line_amount(i),
              description:   tab.old_description(i)
          }
        when :new
          pulled_asset = {
              qty:           tab.qty(i),
              type:          tab.type(i),
              manufacturer:  tab.manufacturer(i),
              line_amount:   tab.line_amount(i),
              description:   tab.description(i)
          }
      end
    end

    pulled_asset
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_asset(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end


end
