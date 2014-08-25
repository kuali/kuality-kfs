class ProjectDirectorLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :principal_name, :primary, :active, :title

  def initialize(browser, opts={})
    @browser = browser

    defaults = { active: :set }

    set_options(defaults.merge(opts))
  end

  def create
     on ProjectDirectorsTab do |tab|
       tab.new_project_director_principal_name.fit         @principal_name
       tab.new_project_director_primary.fit                @primary
       tab.new_project_director_title.fit                  @title
       tab.new_project_director_active_indicator.fit       @active
       fill_out_extended_attributes
       tab.add_new_project_director
    end
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def edit_attributes(opts = {})
    on ProjectDirectorsTab do |tab|
      tab.update_project_director_principal_name(@line_number).fit    opts[:principal_name]
      tab.update_project_director_primary(@line_number).fit           opts[:primary]
      tab.update_project_director_title(@line_number).fit             opts[:title]
      tabupdate_project_director_active_indicator(@line_number).fit  opts[:active]
    end
    update_options(opts)
  end

  def delete
    on(ProjectDirectorsTab).delete_project_director @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

end

class ProjectDirectorLineObjectCollection < LineObjectCollection

  contains ProjectDirectorLineObject

  def update_from_page!(target=:new)
    on ProjectDirectorsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      unless lines.current_project_director_count.zero?
        (0..(lines.current_project_director_count - 1)).to_a.collect!{ |i|
          pull_existing_project_director(i, target).merge(pull_extended_existing_project_director(i, target))
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
  def pull_existing_project_director(i=0, target=:new)
    pulled_project_director = Hash.new

    on ProjectDirectorsTab do |tab|
      case target
        when :old
          pulled_project_director = {
              principal_name:       tab.old_project_director_principal_name(i),
              title:                tab.old_project_director_title(i),
              primary:              yesno2setclear(tab.old_project_director_primary_indicator(i)),
              active:               yesno2setclear(tab.old_project_director_active_indicator(i))
          }
        when :new
          pulled_project_director = {
              principal_name:       tab.update_project_director_principal_name(i).selected_options.first.text,
              title:                tab.update_project_director_title(i),
              primary:              yesno2setclear(tab.update_project_director_primary_indicator(i).value),
              active:               yesno2setclear(tab.update_project_director_active_indicator(i).value)
          }
      end
    end

    pulled_project_director
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @param [Symbol] target Which address to pull from (most useful during a copy action). Defaults to :new
  # @return [Hash] The return values of attributes for the given line
  def pull_extended_existing_project_director(i=0, target=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

