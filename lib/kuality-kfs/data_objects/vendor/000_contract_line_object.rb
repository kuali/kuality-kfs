class ContractLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

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
      vp.new_contract_campus_code.pick!         @campus_code
      vp.new_contract_begin_date.fit            @begin_date
      vp.new_contract_end_date.fit              @end_date
      vp.new_contract_manager.pick!             @manager
      vp.new_contract_po_cost_source.pick!      @po_cost_source
      vp.new_b2b_contract_indicator.pick        @b2b
      vp.new_contract_payment_terms.pick!       @payment_terms
      vp.new_contract_shipping_terms.pick!      @shipping_terms
      vp.new_contract_shipping_title.pick!      @shipping_title
      vp.new_contract_extension_option_date.fit @extension_option_date
      vp.new_contract_default_apo_limit.fit     @default_apo_limit
      vp.new_contact_active_indicator.fit       @active
      fill_out_extended_attributes
      vp.add_contract
      @number = vp.update_contract_number(vp.current_contracts_count - 1) # Contracts get tacked onto the end
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      raise ArgumentError, 'Contract Numbers cannot be modified.' unless opts[:number].nil?
      vp.update_contract_name(@line_number).fit                  opts[:name]
      vp.update_contract_description(@line_number).fit           opts[:description]
      vp.update_contract_campus_code(@line_number).pick!         opts[:campus_code]
      vp.update_contract_begin_date(@line_number).fit            opts[:begin_date]
      vp.update_contract_end_date(@line_number).fit              opts[:end_date]
      vp.update_contract_manager(@line_number).pick!             opts[:manager]
      vp.update_contract_po_cost_source(@line_number).pick!      opts[:po_cost_source]
      vp.update_b2b_contract_indicator(@line_number).pick!       opts[:b2b]
      vp.update_contract_payment_terms(@line_number).pick!       opts[:payment_terms]
      vp.update_contract_shipping_terms(@line_number).pick!      opts[:shipping_terms]
      vp.update_contract_shipping_title(@line_number).pick!      opts[:shipping_title]
      vp.update_contract_extension_option_date(@line_number).fit opts[:extension_option_date]
      vp.update_contract_default_apo_limit(@line_number).fit     opts[:default_apo_limit]
      vp.update_contract_active_indicator(@line_number).fit      opts[:active]
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

  def update_from_page!(target=:new)
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_contracts_count.zero?
        (0..(lines.current_contracts_count - 1)).to_a.collect!{ |i|
          pull_existing_contract(i, target).merge(pull_extended_existing_contract(i, target))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contract to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_contract(i=0, target=:new)
    pulled_contract = Hash.new

    on VendorPage do |vp|
      case target
        when :old
          pulled_contract = {
            number:                vp.old_contract_number(i),
            name:                  vp.old_contract_name(i),
            description:           vp.old_contract_description(i),
            campus_code:           vp.old_contract_campus_code(i),
            begin_date:            vp.old_contract_begin_date(i),
            end_date:              vp.old_contract_end_date(i),
            manager:               vp.old_contract_manager(i),
            po_cost_source:        vp.old_contract_po_cost_source(i),
            b2b:                   vp.old_b2b_contract_indicator(i),
            payment_terms:         vp.old_contract_payment_terms(i),
            shipping_terms:        vp.old_contract_shipping_terms(i),
            shipping_title:        vp.old_contract_shipping_title(i),
            extension_option_date: vp.old_contract_extension_option_date(i),
            default_apo_limit:     vp.old_contract_default_apo_limit(i),
            active:                yesno2setclear(vp.old_contract_active_indicator(i))
          }
        when :new
          pulled_contract = {
            number:                vp.update_contract_number(i),
            name:                  vp.update_contract_name(i).value.strip,
            description:           vp.update_contract_description(i).value.strip,
            campus_code:           vp.update_contract_campus_code(i).selected_options.first.value,
            begin_date:            vp.update_contract_begin_date(i).value.strip,
            end_date:              vp.update_contract_end_date(i).value.strip,
            manager:               vp.update_contract_manager(i).selected_options.first.text,
            po_cost_source:        vp.update_contract_po_cost_source(i).selected_options.first.text,
            b2b:                   vp.update_b2b_contract_indicator(i).selected_options.first.text,
            payment_terms:         vp.update_contract_payment_terms(i).selected_options.first.text,
            shipping_terms:        vp.update_contract_shipping_terms(i).selected_options.first.text,
            shipping_title:        vp.update_contract_shipping_title(i).selected_options.first.text,
            extension_option_date: vp.update_contract_extension_option_date(i).value.strip,
            default_apo_limit:     vp.update_contract_default_apo_limit(i).value.strip,
            active:                yesno2setclear(vp.update_contract_active_indicator(i).value)
          }
      end
    end

    pulled_contract
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contract to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_contract(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end