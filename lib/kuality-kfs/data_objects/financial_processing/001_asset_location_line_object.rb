class AssetLocationLineObject < DataFactory

  include GlobalConfig

  attr_accessor   :line_number,
                  :parent,
                  :tag_number, :capital_asset_campus, :capital_asset_building,
                  :capital_asset_room

  def defaults
    Hash.new
  end

  def initialize(browser, opts={})
    puts 'asset loc line init'
    @browser = browser
    defaults = { capital_asset_campus: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE) }
    #set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ASSETS))
    #            .merge(opts))
    set_options(defaults.merge(opts))
  end

  def pre_create; end

  def post_create; end

  def create
    puts 'asset loc line create'
    pre_create
    build
    fill_out_extended_attributes
    if on(CapitalAssetsTab).asset_detail_tables.length > 1
      on CapitalAssetsTab do |tab|
        tab.tag_number(@parent.parent.line_number).fit               @tag_number
        tab.capital_asset_campus(@parent.parent.line_number).fit     @capital_asset_campus
        tab.capital_asset_building(@parent.parent.line_number).fit   @capital_asset_building
        tab.capital_asset_room(@parent.parent.line_number).fit       @capital_asset_room
        fill_out_extended_attributes
      end
    end
    post_create
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def build
    do_mappings_fill({
                         tag_number:                @tag_number,
                         capital_asset_campus:      @capital_asset_campus,
                         capital_asset_building:    @capital_asset_building,
                         capital_asset_room:        @capital_asset_room
                     })
  end

  def edit_attributes(opts = {})
    do_mappings_fill({
                         tag_number:                      opts[:tag_number],
                         capital_asset_campus:            opts[:capital_asset_campus],
                         capital_asset_building:          opts[:capital_asset_building],
                         capital_asset_room:              opts[:capital_asset_room]
                     })
  end

  def delete
    on(CapitalAssetsTab).delete_asset_location(@parent.parent.line_number, @line_number)
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  def edit_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  private

  def do_mappings_fill(mappings)
    on CapitalAssetsTab do |page|
      mappings.each do |field, value|
        lmnt = page.send(*[field, @parent.parent.line_number].compact)
        var = value.nil? ? instance_variable_get("@#{field}") : value
        lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
      end
    end
  end

end

class AssetLocationLineObjectCollection < LineObjectCollection

  contains AssetLocationLineObject

  attr_accessor :parent

  def update_from_page!(target=:new)
    on CapitalAssetsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      (0..(lines.current_asset_location_count(@parent.line_number) - 1)).to_a.collect!{ |i|
        lines.pull_existing_line_values(i, target)
        .merge(pull_extended_existing_line_values(i, target))
      }.each { |new_obj|
        # Update the stored lines
        self << (make contained_class, new_obj)
      }

    end
  end

  # @param [Fixnum] i The Accounting Line line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_existing_line_values(i=0, t=:new) # TODO: ItemAccountingLineObjectCollection#pull_existing_line_values
    # This will need to utilize the value of @parent.line_number to get the right line info
    pulled_item = {}
    on CapitalAssetsTab do |b|
      case t
        when :new
          pulled_item = {
              tag_number:                      b.tag_number(i).value.strip,
              capital_asset_campus:            b.capital_asset_campus(i).selected_options.first.text.strip,
              capital_asset_building:          b.capital_asset_building(i).value.strip,
              capital_asset_room:              b.capital_asset_room(i).value.strip
          }
        when :old
          pulled_item = {
              tag_number:                b.old_tag_number(i),
              capital_asset_campus:      b.old_capital_asset_campus(i),
              capital_asset_building:    b.old_capital_asset_building(i),
              capital_asset_room:        b.old_capital_asset_room(i)
          }
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end
    end
    pulled_item
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_extended_existing_line_values(i=0, t=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

