class ItemLineObject < DataFactory

  include Utilities
  include GlobalConfig

  attr_accessor   :line_number,
                  :type, :quantity, :uom,
                  :catalog_number, :commodity_code, :description,
                  :unit_cost, :po_unit_ext_price, :extended_cost, :restricted,
                  :assigned_to_trade_in,
                  :e_shop_flags # TODO: e-SHOP Flags still needs to be implemented
  alias_method :restricted?, :restricted
  alias_method :assigned_to_trade_in?, :assigned_to_trade_in

  def defaults
    default_item_accounting_lines.merge({
      quantity:             '1000',
      uom:                  'BX', # TODO: Get this from the service
      catalog_number:       random_alphanums(7, 'AFT'),
      description:          random_alphanums(15, 'AFT Item'),
      unit_cost:            '9.9'
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
    on ItemsTab do |tab|
      tab.type.pick!               @type
      tab.quantity.fit             @quantity
      tab.uom.fit                  @uom
      tab.catalog_number.fit       @catalog_number
      tab.commodity_code.fit       @commodity_code
      tab.description.fit          @description
      tab.unit_cost.fit            @unit_cost
      tab.restricted.fit           @restricted
      tab.assigned_to_trade_in.fit @assigned_to_trade_in
      #page.extended_cost.fit        @extended_cost # This is read-only for REQ and calculated for PREQ
      if ItemsTab::on_process_items?(tab)
        tab.update_extended_cost(@line_number).fit @extended_cost
      else
        @extended_cost = tab.result_extended_cost
      end
      @po_unit_ext_price = tab.result_po_unit_ext_price(@line_number) # This is a read-only value, only on PREQ
    end
  end

  def edit_attributes(opts = {})
    on ItemsTab do |page|
      page.update_type(@line_number).pick!               opts[:type] unless opts[:type].nil?
      page.update_quantity(@line_number).fit             opts[:quantity] unless opts[:quantity].nil?
      page.update_uom(@line_number).fit                  opts[:uom] unless opts[:uom].nil?
      page.update_catalog_number(@line_number).fit       opts[:catalog_number] unless opts[:catalog_number].nil?
      page.update_commodity_code(@line_number).fit       opts[:commodity_code] unless opts[:commodity_code].nil?
      page.update_description(@line_number).fit          opts[:description] unless opts[:description].nil?
      page.update_unit_cost(@line_number).fit            opts[:unit_cost] unless opts[:unit_cost].nil?
      page.update_extended_cost(@line_number).fit        opts[:extended_cost] unless opts[:extended_cost].nil?
      page.update_restricted(@line_number).fit           opts[:restricted] unless opts[:restricted].nil?
      page.update_assigned_to_trade_in(@line_number).fit opts[:assigned_to_trade_in] unless opts[:assigned_to_trade_in].nil?
    end
    update_options(opts)
  end
  
  def delete
    on(ItemsTab).delete_item(@line_number)
  end

  def calculate
    on ItemsTab do |tab|
      raise NoMethodError, 'Cannot calculate Items when on a Requisition!' unless ItemsTab::on_process_items?(tab)
      tab.calculate_item(@line_number)
      @extended_cost = tab.update_extended_cost(@line_number).value.strip
    end
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
        pull_existing_items(i, target).merge(pull_extended_existing_items(i, target))
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
            type:                 (b.update_type(i).exists? ? b.update_type(i).selected_options.first.text.strip : b.result_type(i)),
            quantity:             (b.update_quantity(i).present? ? b.update_quantity(i).value.strip : b.result_quantity(i)),
            uom:                  (b.update_uom(i).exists? ? b.update_uom(i).value.strip : b.result_uom(i)),
            catalog_number:       (b.update_catalog_number(i).exists? ? b.update_catalog_number(i).value.strip : b.result_catalog_number(i)),
            commodity_code:       (b.update_commodity_code(i).exists? ? b.update_commodity_code(i).value.strip : b.result_commodity_code(i)),
            description:          (b.update_description(i).exists? ? b.update_description(i).value.strip : b.result_description(i)),
            unit_cost:            (b.update_unit_cost(i).exists? ? b.update_unit_cost(i).value.strip : b.result_unit_cost(i)),
            po_unit_ext_price:    b.result_po_unit_ext_price(i), # This is read-only, as far as we know...
            extended_cost:        (b.update_extended_cost(i).exists? ? b.update_extended_cost(i).value.strip : b.result_extended_cost(i)),
            restricted:           yesno2setclear(b.update_restricted(i).exists? ? b.update_restricted(i).value.strip : b.result_restricted(i)),
            assigned_to_trade_in: yesno2setclear(b.update_assigned_to_trade_in(i).exists? ? b.update_assigned_to_trade_in(i).value.strip : b.result_assigned_to_trade_in(i))
          }
        when :readonly, :old
          pulled_item = {
            type:                 b.result_type(i),
            quantity:             b.result_quantity(i),
            uom:                  b.result_uom(i),
            catalog_number:       b.result_catalog_number(i),
            commodity_code:       b.result_commodity_code(i),
            description:          b.result_description(i),
            unit_cost:            b.result_unit_cost(i),
            po_unit_ext_price:    b.result_po_unit_ext_price(i),
            extended_cost:        b.result_extended_cost(i),
            restricted:           yesno2setclear(b.result_restricted(i)),
            assigned_to_trade_in: yesno2setclear(b.result_assigned_to_trade_in(i))
          }
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end
    end
    pulled_item[:quantity] = pulled_item[:quantity].gsub(/,/,'') unless pulled_item[:quantity].nil?
    pulled_item.delete_if { |_, v| v.nil? }
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