class PhoneLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :type, :number, :extension, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
    # For now, this only supports Vendor. We'll need to refactor appropriately
    # if any other object needs this collection.
    on VendorPage do |vp|
      vp.phone_type.pick!           @type
      vp.phone_number.fit           @number
      vp.phone_extension.fit        @extension
      vp.phone_active_indicator.fit @active
      fill_out_extended_attributes
      vp.add_phone_number
    end
  end

  def edit(opts={})
    on VendorPage do |vp|
      vp.update_phone_type(@line_number).pick!           opts[:type]
      vp.update_phone_number(@line_number).fit           opts[:number]
      vp.update_phone_extension(@line_number).fit        opts[:extension]
      vp.update_phone_active_indicator(@line_number).fit opts[:active]
    end
    update_options(opts)
  end

  def delete
    on(VendorPage).delete_phone_number @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class PhoneLineObjectCollection < LineObjectCollection

  contains PhoneLineObject

  def update_from_page!(target=:new)
    on VendorPage do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      lines.expand_all
      unless lines.current_phone_number_count.zero?
        (0..(lines.current_phone_number_count - 1)).to_a.collect!{ |i|
          pull_existing_phone(i, target).merge(pull_extended_existing_phone(i, target))
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
  def pull_existing_phone(i=0, target=:new)
    pulled_phone = Hash.new

    on VendorPage do |vp|
      case target
        when :old
          pulled_phone = {
              type:      vp.old_phone_type(i),
              number:    vp.old_phone_number(i),
              extension: vp.old_phone_extension(i),
              active:    yesno2setclear(vp.old_phone_active_indicator(i))
          }
        when :new
          pulled_phone = {
              type:      vp.update_phone_type(i).selected_options.first.text,
              number:    vp.update_phone_number(i).value.strip,
              extension: vp.update_phone_extension(i).value.strip,
              active:    yesno2setclear(vp.update_phone_active_indicator(i).value)
          }
      end
    end

    pulled_phone
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_phone(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end