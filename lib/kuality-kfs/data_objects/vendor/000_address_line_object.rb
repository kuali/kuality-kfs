class AddressLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :type,
                  :address_1, :address_2,
                  :city, :state, :postal_code,
                  :province, :country, :attention,
                  :url, :fax, :email,
                  :set_as_default, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:           'PO - PURCHASE ORDER',
      address_1:      get_generic_address_1,
      city:           get_generic_city,
      state:          get_random_state_code,
      postal_code:    get_random_postal_code('NY'),
      country:        'United States',
      set_as_default: 'Yes',
      active:         :set
    }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    on VendorPage do |vp|
      vp.address_type.pick!           @type
      vp.address_1.fit                @address_1
      vp.address_2.fit                @address_2
      vp.city.fit                     @city
      vp.state.fit                    @state
      vp.zipcode.fit                  @postal_code
      vp.province.fit                 @province
      vp.country.pick!                @country
      vp.address_attention.fit        @attention
      vp.address_url.fit              @url
      vp.fax.fit                      @fax
      vp.email.fit                    @email
      vp.default_address.pick!        @set_as_default
      vp.address_active_indicator.fit @active
      fill_out_extended_attributes
      vp.add_address
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      vp.update_address_type(@line_number).pick! opts[:type]
      vp.update_address_1(@line_number).fit      opts[:address_1]
      vp.update_address_2(@line_number).fit      opts[:address_2]
      vp.update_city(@line_number).fit           opts[:city]
      vp.update_state(@line_number).fit          opts[:state]
      vp.update_zipcode(@line_number).fit        opts[:postal_code]
      vp.update_province(@line_number).fit       opts[:province]
      vp.update_country(@line_number).pick!      opts[:country]
      vp.update_address_attention(@line_number).fit opts[:attention]
      vp.update_address_url(@line_number).fit       opts[:url]
      vp.update_fax(@line_number).fit               opts[:fax]
      vp.update_email(@line_number).fit             opts[:email]
      vp.update_default_address(@line_number).pick! opts[:set_as_default]
      vp.update_address_active_indicator(@line_number).fit opts[:active]
    end
    update_options(opts)
    update_extended_attributes(opts)
  end

  def delete
    raise NoMethodError, 'There is no way to delete an Address from a Vendor. Perhaps you have a site-specific extension?'
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class AddressLineObjectCollection < LineObjectCollection

  contains AddressLineObject

  def update_from_page!(target=:new)
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_address_count.zero?
        (0..(lines.current_address_count - 1)).to_a.collect!{ |i|
          pull_existing_address(i, target).merge(pull_extended_existing_address(i, target))
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
  def pull_existing_address(i=0, target=:new)
    pulled_address = Hash.new

    on VendorPage do |vp|
      case target
        when :old
          pulled_address = {
            type:           vp.old_address_type(i),
            address_1:      vp.old_address_1(i),
            address_2:      vp.old_address_2(i),
            city:           vp.old_city(i),
            state:          vp.old_state(i),
            postal_code:    vp.old_zipcode(i),
            province:       vp.old_province(i),
            country:        vp.old_country(i),
            attention:      vp.old_address_attention(i),
            url:            vp.old_address_url(i),
            fax:            vp.old_fax(i),
            email:          vp.old_email(i),
            set_as_default: vp.old_default_address(i),
            active:         yesno2setclear(vp.old_address_active_indicator(i))
          }
        when :new
          pulled_address = {
            type:           vp.update_address_type(i).selected_options.first.text.strip,
            address_1:      vp.update_address_1(i).value.strip,
            address_2:      vp.update_address_2(i).value.strip,
            city:           vp.update_city(i).value.strip,
            state:          vp.update_state(i).value.strip,
            postal_code:    vp.update_zipcode(i).value.strip,
            province:       vp.update_province(i).value.strip,
            country:        vp.update_country(i).selected_options.first.text.strip,
            attention:      vp.update_address_attention(i).value.strip,
            url:            vp.update_address_url(i).value.strip,
            fax:            vp.update_fax(i).value.strip,
            email:          vp.update_email(i).value.strip,
            set_as_default: vp.update_default_address(i).selected_options.first.text,
            active:         yesno2setclear(vp.update_address_active_indicator(i).value.strip)
          }
      end
    end

    pulled_address
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_address(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end