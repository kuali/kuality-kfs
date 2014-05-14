class ContactLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

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
      vp.new_contact_type.pick!           @type
      vp.new_contact_name.fit             @name
      vp.new_contact_email.fit            @email
      vp.new_contact_address_1.fit        @address_1
      vp.new_contact_address_2.fit        @address_2
      vp.new_contact_city.fit             @city
      vp.new_contact_state.fit            @state
      vp.new_contact_zipcode.fit          @postal_code
      vp.new_contact_province.fit         @province
      vp.new_contact_country.pick!        @country
      vp.new_contact_attention.fit        @attention
      vp.new_contact_comments.fit         @comments
      vp.new_contact_active_indicator.fit @active
      fill_out_extended_attributes
      vp.add_contact
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      vp.update_contact_type(@line_number).pick!           opts[:type]
      vp.update_contact_name(@line_number).fit             opts[:name]
      vp.update_contact_email(@line_number).fit            opts[:email]
      vp.update_contact_address_1(@line_number).fit        opts[:address_1]
      vp.update_contact_address_2(@line_number).fit        opts[:address_2]
      vp.update_contact_city(@line_number).fit             opts[:city]
      vp.update_contact_state(@line_number).fit            opts[:state]
      vp.update_contact_zipcode(@line_number).fit          opts[:postal_code]
      vp.update_contact_province(@line_number).fit         opts[:province]
      vp.update_contact_country(@line_number).pick!        opts[:country]
      vp.update_contact_attention(@line_number).fit        opts[:attention]
      vp.update_contact_comments(@line_number).fit         opts[:comments]
      vp.update_contact_active_indicator(@line_number).fit opts[:active]
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

  def update_from_page!(target=:new)
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_contacts_count.zero?
        (0..(lines.current_contacts_count - 1)).to_a.collect!{ |i|
          pull_existing_contact(i, target).merge(pull_extended_existing_contact(i, target))
        }.each { |new_obj|
          # Update the stored lines
          self << (make contained_class, new_obj)
        }
      end

    end
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contact to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_existing_contact(i=0, target=:new)
    pulled_contact = Hash.new

    on VendorPage do |vp|
      case target
        when :old
          pulled_contact = {
            type:           vp.old_contact_type(i),
            name:           vp.old_contact_name(i),
            email:          vp.old_contact_email(i),
            address_1:      vp.old_contact_address_1(i),
            address_2:      vp.old_contact_address_2(i),
            city:           vp.old_contact_city(i),
            state:          vp.old_contact_state(i),
            postal_code:    vp.old_contact_zipcode(i),
            province:       vp.old_contact_province(i),
            country:        vp.old_contact_country(i),
            attention:      vp.old_contact_attention(i),
            comments:       vp.old_contact_comments(i),
            active:         yesno2setclear(vp.old_contact_active_indicator(i))
          }
        when :new
          pulled_contact = {
            type:           vp.update_contact_type(i).selected_options.first.text.strip,
            name:           vp.update_contact_name(i).value.strip,
            email:          vp.update_contact_email(i).value.strip,
            address_1:      vp.update_contact_address_1(i).value.strip,
            address_2:      vp.update_contact_address_2(i).value.strip,
            city:           vp.update_contact_city(i).value.strip,
            state:          vp.update_contact_state(i).value.strip,
            postal_code:    vp.update_contact_zipcode(i).value.strip,
            province:       vp.update_contact_province(i).value.strip,
            country:        vp.update_contact_country(i).selected_options.first.text,
            attention:      vp.update_contact_attention(i).value.strip,
            comments:       vp.update_contact_comments(i).value.strip,
            active:         yesno2setclear(vp.update_contact_active_indicator(i).value.strip)
          }
      end
    end

    pulled_contact
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which contact to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_contact(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end