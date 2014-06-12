class ProductLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number, :parent,
                  :description, :catalog_number,
                  :size, :packaging,
                  :unit_price, :quantity,
                  :extended_price, :extended_price_units

  def defaults
    { quantity: '1' }
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(opts))
  end

  # Currently, #create doesn't really interact with the page because we add
  # items to this sort of collection through the shop search pages. Hence, we're
  # simply absorbing the info from the page.
  def create
    on ShopCartPage do |scp|
      scp.update_product_quantity(parent.supplier_name, @line_number).fit @quantity unless @quantity.nil?

      line = scp.line_item_values(parent.supplier_name, @line_number)
      @description          = line[:product_description]
      @catalog_number       = line[:catalog_no]
      @size                 = line[:size_packaging][:size]
      @packaging            = line[:size_packaging][:packaging]
      @unit_price           = line[:unit_price]
      @quantity             = line[:quantity][:value]
      @extended_price       = line[:ext_price][:value]
      @extended_price_units = line[:ext_price][:units]
    end

    fill_out_extended_attributes
  end

  def edit(opts={})
    on(ShopCartPage).update_product_quantity(parent.supplier_name, @line_number).fit opts[:quantity]
    update_extended_attributes
    update_options(opts)
  end

  def delete
    on(ShopCartPage).delete_product(parent.supplier_name, @line_number)
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class ProductLineObjectCollection < LineObjectCollection

  contains ProductLineObject

  attr_accessor :supplier_name, :supplier_subtotal

  def <<(lo)
    lo.parent = self
    super(lo)
  end

  def update_from_page!
    on ShopCartPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_product_count.zero? # TODO: Define a way to pull the current product count
        (0..(lines.current_product_count - 1)).to_a.collect!{ |i|
          # Update the stored lines
          self << (create contained_class, quantity: nil)
        }
      end

    end
  end

end