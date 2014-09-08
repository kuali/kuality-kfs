class OrganizationLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :chart_code, :organization_code, :primary, :active

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
     on OrganizationsTab do |tab|
       tab.new_organization_chart_code.fit       @chart_code
       tab.new_organization_code.fit             @organization_code
       tab.new_organization_primary.fit          @primary
       tab.new_organization_active_indicator.fit @active
       fill_out_extended_attributes
       tab.add_new_organization
    end
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def edit_attributes(opts = {})
    on OrganizationsTab do |tab|
      raise ArgumentError, 'Chart Code cannot be updated!' unless opts[:chart_code].nil?
      raise ArgumentError, 'Organization Code cannot be updated!' unless opts[:organization_code].nil?
      tab.update_organization_primary(@line_number).fit           opts[:primary]
      tab.update_organization_active_indicator(@line_number).fit  opts[:active]
    end
    update_options(opts)
  end

  def delete
    on(OrganizationsTab).delete_organization @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class OrganizationLineObjectCollection < LineObjectCollection

  contains OrganizationLineObject

  def update_from_page!(target=:new)
    on OrganizationsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_organization_count.zero?
        (0..(lines.current_organization_count - 1)).to_a.collect!{ |i|
          pull_existing_organization(i, target).merge(pull_extended_existing_organization(i, target))
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
  def pull_existing_organization(i=0, target=:new)
    pulled_organization = Hash.new

    on OrganizationsTab do |tab|
      case target
        when :old
          pulled_organization = {
              chart_code:           tab.old_organization_chart_code(i),
              organization_code:    tab.old_organization_code(i),
              primary:              yesno2setclear(tab.old_organization_primary(i)),
              active:               yesno2setclear(tab.old_organization_active_indicator(i))
          }
        when :new
          pulled_organization = {
              chart_code:           tab.update_organization_chart_code(i).text.strip,
              organization_code:    tab.update_organization_code(i).text.strip,
              primary:              yesno2setclear(tab.update_organization_primary(i).value),
              active:               yesno2setclear(tab.update_organization_active_indicator(i).value)
          }
      end
    end

    pulled_organization
    pulled_organization.delete_if { |_, v| v.nil? }
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_organization(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

