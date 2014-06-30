class ItemLineObject < DataFactory

  include Utilities
  include GlobalConfig

  attr_accessor   :line_number,
                  :type, :quantity, :uom,
                  :catalog_number, :commodity_code, :description,
                  :unit_cost, :extended_cost, :restricted,
                  :assigned_to_trade_in,
                  :e_shop_flags # TODO: e-SHOP Flags still needs to be implemented
  alias_method :restricted?, :restricted
  alias_method :assigned_to_trade_in?, :assigned_to_trade_in

  def defaults
    default_item_accounting_lines.merge({
      # type:                 '',
      quantity:             '1000',
      uom:                  'BX', # TODO: Get this from the service
      catalog_number:       random_alphanums(7, 'AFT'),
      # commodity_code:       '',
      description:          random_alphanums(15, 'AFT Item'),
      unit_cost:            '9.9' #,
      # extended_cost:        '',
      # restricted:           '',
      # assigned_to_trade_in: ''
    })
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ITEMS))
                        .merge(opts))
    post_initialize
  end

  def create
    pre_create
    build
    fill_out_extended_attributes
    on(ItemsTab).add_item
    post_create
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def post_initialize; end

  def pre_create; end

  def post_create; end

  def build
    on ItemsTab do |page|
      page.type.pick!               @type
      page.quantity.fit             @quantity
      page.uom.fit                  @uom
      page.catalog_number.fit       @catalog_number
      page.commodity_code.fit       @commodity_code
      page.description.fit          @description
      page.unit_cost.fit            @unit_cost
      #page.extended_cost.fit        @extended_cost # This is read-only
      page.restricted.fit           @restricted
      page.assigned_to_trade_in.fit @assigned_to_trade_in
    end
  end

  def edit_attributes(opts = {})
    on ItemsTab do |page|
      page.update_type(@line_number).pick!               opts[:type]
      page.update_quantity(@line_number).fit             opts[:quantity]
      page.update_uom(@line_number).fit                  opts[:uom]
      page.update_catalog_number(@line_number).fit       opts[:catalog_number]
      page.update_commodity_code(@line_number).fit       opts[:commodity_code]
      page.update_description(@line_number).fit          opts[:description]
      page.update_unit_cost(@line_number).fit            opts[:unit_cost]
      # page.update_extended_cost(@line_number).fit        opts[:extended_cost] # This is read-only
      page.update_restricted(@line_number).fit           opts[:restricted]
      page.update_assigned_to_trade_in(@line_number).fit opts[:assigned_to_trade_in]
    end
  end
  
  def delete
    on(ItemsTab).delete_item(@line_number)
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def edit_extended_attributes(attribute_group=nil)
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  include ItemAccountingLinesMixin # Need to include this to provide the inner Accounting Lines

end

class ItemLineObjectCollection < LineObjectCollection

  contains ItemLineObject

  # Provides the line import button and makes it so you don't need to provide
  # a superfluous index to click the button.
  # @param [String] file_name The name of the file to import, relative to the resources folder
  def import_lines(file_name)
    on ItemsTab do |tab|
      tab.import_item_lines
      tab.item_line_file_name.set($file_folder+file_name)
      tab.add_item_import
      update_from_page!
    end
  end

  def update_from_page!(target=:new)
    on ItemsTab do |tab|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      (0..(tab.current_items_count - 1)).to_a.collect!{ |i|
        pull_existing_items(i, target).merge(pull_extended_existing_items(i, target)) # TODO: Make sure ItemsTab#pull_existing_items works
      }.each { |new_obj|
        # Update the stored lines
        self << (make contained_class, new_obj)
        self.last.accounting_lines.update_from_page! target
      }

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_items(i=0, t=:new)
    pulled_item = {}
    on ItemsTab do |b|
      case t
        when :new
          pulled_item = {
            type:                 (b.update_type(i).exists? ? b.update_type(i) : b.result_type(i)).selected_options.first.text.strip,
            quantity:             b.update_quantity(i).value.strip,
            uom:                  (b.update_uom(i).exists? ? b.update_uom(i) : b.result_uom(i)).value.strip,
            catalog_number:       (b.update_catalog_number(i).exists? ? b.update_catalog_number(i) : b.result_catalog_number(i)).value.strip,
            commodity_code:       b.update_commodity_code(i).value.strip,
            description:          (b.update_description(i).exists? ? b.update_description(i) : b.result_description(i)).value.strip,
            unit_cost:            (b.update_unit_cost(i).exists? ? b.update_unit_cost(i) : b.result_unit_cost(i)).value.strip,
            extended_cost:        (b.update_extended_cost(i).exists? ? b.update_extended_cost(i) : b.result_extended_cost(i)).value.strip,
            restricted:           yesno2setclear((b.update_restricted(i).exists? ? b.update_restricted(i) : b.result_restricted(i)).value.strip),
            assigned_to_trade_in: yesno2setclear((b.update_assigned_to_trade_in(i).exists? ? b.update_assigned_to_trade_in(i) : b.result_assigned_to_trade_in(i)).value.strip)
          }
        when :readonly, :old
          pulled_item = {
            type:                 b.result_type(i).selected_options.first.text.strip,
            quantity:             b.result_quantity(i).value.strip,
            uom:                  b.result_uom(i).value.strip,
            catalog_number:       b.result_catalog_number(i).value.strip,
            commodity_code:       b.result_commodity_code(i).value.strip,
            description:          b.result_description(i).value.strip,
            unit_cost:            b.result_unit_cost(i).value.strip,
            extended_cost:        b.result_extended_cost(i).value.strip,
            restricted:           yesno2setclear(b.result_restricted(i).value.strip),
            assigned_to_trade_in: yesno2setclear(b.result_assigned_to_trade_in(i).value.strip)
          }
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end
    end
    pulled_item.compact
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_extended_existing_items(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end