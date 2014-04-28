class AddressLineObject < DataFactory

  include DateFactory
  include StringFactory

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
      type:                      'PO - PURCHASE ORDER',
      address_1:                 '6655 Sunset BLvd',
      city:                      'Denver',
      state:                     'CO',
      postal_code:               '91190',
      country:                   'United States',
      set_as_default:            'Yes',
      active:                    :set
    }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    on VendorPage do |vp|
      vp.address_type.fit              @type
      vp.address_1.fit                 @address_1
      vp.address_2.fit                 @address_2
      vp.city.fit                      @city
      vp.state.fit                     @state
      vp.zipcode.fit                   @postal_code
      vp.province.fit                  @province
      vp.country.fit                   @country
      vp.address_attention.fit         @attention
      vp.address_url.fit               @url
      vp.fax.fit                       @fax
      vp.email.fit                     @email
      vp.default_address.fit           @set_as_default
      vp.address_active_indicator.fit  @active
      fill_out_extended_attributes
      vp.add_address
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      vp.update_address_type(@line_number).fit opts[:type]
      vp.update_address_1(@line_number).fit    opts[:address_1]
      vp.update_address_2(@line_number).fit    opts[:address_2]
      vp.update_city(@line_number).fit         opts[:city]
      vp.update_state(@line_number).fit        opts[:state]
      vp.update_zipcode(@line_number).fit      opts[:postal_code]
      vp.update_province(@line_number).fit     opts[:province]
      vp.update_country(@line_number).fit      opts[:country]
      vp.update_address_attention(@line_number).fit opts[:attention]
      vp.update_address_url(@line_number).fit       opts[:url]
      vp.update_fax(@line_number).fit               opts[:fax]
      vp.update_email(@line_number).fit             opts[:email]
      vp.update_default_address(@line_number).fit   opts[:set_as_default]
      vp.update_address_active_indicator(@line_number).fit  opts[:active]
    end
    update_options(opts)
    update_extended_attributes(opts)
  end

  def delete
    raise NoMethodError, 'There is no way to delete an address from a Vendor. Perhaps you have a site-specific extension?'
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

  def update_from_page!
    on VendorPage do |lines|
      lines.expand_all
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_address_count.zero?
        (0..(lines.current_address_count - 1)).to_a.collect!{ |i|
          lines.pull_existing_address(i).merge(pull_extended_existing_address(i))
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
  def pull_extended_existing_address(i=0)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end