class ContractLineObject < DataFactory

  include DateFactory
  include StringFactory

  attr_accessor   :line_number,
                  :number, :name,
                  :description, :campus_code,
                  :begin_date, :end_date,
                  :manager, :po_cost_source,
                  :b2b, :payment_terms,
                  :shipping_terms, :shipping_title,
                  :extension_option_date, :default_apo_limit,
                  :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    on VendorPage do |vp|
      raise ArgumentError, 'Contract Numbers cannot be modified.' unless @number.nil?
      vp.new_contract_name.fit                  @name
      vp.new_contract_description.fit           @description
      vp.new_contract_campus_code.fit           @campus_code
      vp.new_contract_begin_date.fit            @begin_date
      vp.new_contract_end_date.fit              @end_date
      vp.new_contract_manager.fit               @manager
      vp.new_contract_po_cost_source.fit        @po_cost_source
      vp.new_b2b_contract_indicator.fit         @b2b
      vp.new_contract_payment_terms.fit         @payment_terms
      vp.new_contract_shipping_terms.fit        @shipping_terms
      vp.new_contract_shipping_title.fit        @shipping_title
      vp.new_contract_extension_option_date.fit @extension_option_date
      vp.new_contract_default_apo_limit.fit     @default_apo_limit
      vp.new_contact_active_indicator.fit       @active
      fill_out_extended_attributes
      vp.add_contact
      @number = vp.update_contract_number(@line_number)
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      raise ArgumentError, 'Contract Numbers cannot be modified.' unless opts[:number].nil?
      vp.update_contract_name(@line_number).fit                  opts[:name] unless opts[:name].nil?
      vp.update_contract_description(@line_number).fit           opts[:description] unless opts[:description].nil?
      vp.update_contract_campus_code(@line_number).fit           opts[:campus_code] unless opts[:campus_code].nil?
      vp.update_contract_begin_date(@line_number).fit            opts[:begin_date] unless opts[:begin_date].nil?
      vp.update_contract_end_date(@line_number).fit              opts[:end_date] unless opts[:end_date].nil?
      vp.update_contract_manager(@line_number).fit               opts[:manager] unless opts[:manager].nil?
      vp.update_contract_po_cost_source(@line_number).fit        opts[:po_cost_source] unless opts[:po_cost_source].nil?
      vp.update_b2b_contract_indicator(@line_number).fit         opts[:b2b] unless opts[:b2b].nil?
      vp.update_contract_payment_terms(@line_number).fit         opts[:payment_terms] unless opts[:payment_terms].nil?
      vp.update_contract_shipping_terms(@line_number).fit        opts[:shipping_terms] unless opts[:shipping_terms].nil?
      vp.update_contract_shipping_title(@line_number).fit        opts[:shipping_title] unless opts[:shipping_title].nil?
      vp.update_contract_extension_option_date(@line_number).fit opts[:extension_option_date] unless opts[:extension_option_date].nil?
      vp.update_contract_default_apo_limit(@line_number).fit     opts[:default_apo_limit] unless opts[:default_apo_limit].nil?
      vp.update_contract_active_indicator(@line_number).fit      opts[:active] unless opts[:active].nil?
    end
    update_options(opts)
    update_extended_attributes(opts)
  end

  def delete
    on(VendorPage).delete_contract @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class ContractLineObjectCollection < LineObjectCollection

  contains ContractLineObject

  def update_from_page!
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_contracts_count.zero?
        (0..(lines.current_contracts_count - 1)).to_a.collect!{ |i|
          lines.pull_existing_contract(i).merge(pull_extended_existing_contract(i))
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
  def pull_extended_existing_contract(i=0)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end