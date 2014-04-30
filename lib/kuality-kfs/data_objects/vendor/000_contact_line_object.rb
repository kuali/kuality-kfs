class ContactLineObject < DataFactory

  include DateFactory
  include StringFactory

  attr_accessor   :line_number,
                  :type, :name, :email,
                  :address_1, :address_2,
                  :city, :state, :postal_code,
                  :province, :country, :attention,
                  :comments, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    on VendorPage do |vp|
      vp.new_contact_type.fit             @type
      vp.new_contact_name.fit             @name
      vp.new_contact_email.fit            @email
      vp.new_contact_address_1.fit        @address_1
      vp.new_contact_address_2.fit        @address_2
      vp.new_contact_city.fit             @city
      vp.new_contact_state.fit            @state
      vp.new_contact_zipcode.fit          @postal_code
      vp.new_contact_province.fit         @province
      vp.new_contact_country.fit          @country
      vp.new_contact_attention.fit        @attention
      vp.new_contact_comments.fit         @comments
      vp.new_contact_active_indicator.fit @active
      fill_out_extended_attributes
      vp.add_contact
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      vp.update_contact_type(@line_number).fit             opts[:type] unless opts[:type].nil?
      vp.update_contact_name(@line_number).fit             opts[:name] unless opts[:name].nil?
      vp.update_contact_email(@line_number).fit            opts[:email] unless opts[:email].nil?
      vp.update_contact_address_1(@line_number).fit        opts[:address_1] unless opts[:address_1].nil?
      vp.update_contact_address_2(@line_number).fit        opts[:address_2] unless opts[:address_2].nil?
      vp.update_contact_city(@line_number).fit             opts[:city] unless opts[:city].nil?
      vp.update_contact_state(@line_number).fit            opts[:state] unless opts[:state].nil?
      vp.update_contact_zipcode(@line_number).fit          opts[:postal_code] unless opts[:postal_code].nil?
      vp.update_contact_province(@line_number).fit         opts[:province] unless opts[:province].nil?
      vp.update_contact_country(@line_number).fit          opts[:country] unless opts[:country].nil?
      vp.update_contact_attention(@line_number).fit        opts[:attention] unless opts[:attention].nil?
      vp.update_contact_comments(@line_number).fit         opts[:comments] unless opts[:comments].nil?
      vp.update_contact_active_indicator(@line_number).fit opts[:active] unless opts[:active].nil?
    end
    update_options(opts)
    update_extended_attributes(opts)
  end

  def delete
    raise NoMethodError, 'There is no way to delete a Contact from a Vendor. Perhaps you have a site-specific extension?'
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class ContactLineObjectCollection < LineObjectCollection

  contains ContactLineObject

  def update_from_page!
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_contacts_count.zero?
        (0..(lines.current_contacts_count - 1)).to_a.collect!{ |i|
          lines.pull_existing_contact(i).merge(pull_extended_existing_contact(i))
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
  def pull_extended_existing_contact(i=0)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end