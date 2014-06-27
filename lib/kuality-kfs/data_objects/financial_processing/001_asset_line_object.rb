class AssetLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number, :capital_asset_manufacturer, :capital_asset_description,
                  :capital_asset_line_amount, :insert_tag, :capital_asset_qty, :capital_asset_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = { capital_asset_type: '019' }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports DI. We'll need to refactor appropriately
    # if any other object needs this collection.
    # asset line is different the normal Kuali collection.  There is no 'new' line to add.
    if on(DistributionOfIncomeAndExpensePage).asset_tables.length > 1
      on DistributionOfIncomeAndExpensePage do |di_page|
        di_page.capital_asset_qty.fit             @capital_asset_qty
        di_page.capital_asset_line_amount.fit     @capital_asset_line_amount
        di_page.capital_asset_type.fit            @capital_asset_type
        di_page.capital_asset_manufacturer.fit    @capital_asset_manufacturer
        di_page.capital_asset_description.fit     @capital_asset_description
        fill_out_extended_attributes
      end
    end
  end

  def edit(opts={})
    on DistributionOfIncomeAndExpensePage do |di_page|
      di_page.capital_asset_qty(@line_number).fit           opts[:capital_asset_qty]
      di_page.capital_asset_line_amount(@line_number).fit   opts[:capital_asset_line_amount]
      di_page.capital_asset_type(@line_number).fit          opts[:capital_asset_type]
      di_page.capital_asset_manufacturer(@line_number).fit  opts[:capital_asset_manufacturer]
      di_page.capital_asset_description(@line_number).fit   opts[:capital_asset_description]
    end
    update_options(opts)
  end

  def delete
    on(DistributionOfIncomeAndExpensePage).delete_asset @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class AssetLineObjectCollection < LineObjectCollection

  contains AssetLineObject

  def update_from_page!(target=:new)
    on DistributionOfIncomeAndExpensePage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
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

    on DistributionOfIncomeAndExpensePage do |di_page|
      case target
        when :old
          pulled_asset = {
              capital_asset_qty:           di_page.old_capital_asset_qty(i),
              capital_asset_type:          di_page.old_capital_asset_type(i),
              capital_asset_manufacturer:  di_page.old_capital_asset_manufacturer(i),
              capital_asset_line_amount:   di_page.old_capital_asset_line_amount(i),
              capital_asset_description:   di_page.old_capital_asset_description(i)
          }
        when :new
          pulled_asset = {
              capital_asset_qty:           di_page.capital_asset_qty(i),
              capital_asset_type:          di_page.capital_asset_type(i),
              capital_asset_manufacturer:  di_page.capital_asset_manufacturer(i),
              capital_asset_line_amount:   di_page.capital_asset_line_amount(i),
              capital_asset_description:   di_page.capital_asset_description(i)
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