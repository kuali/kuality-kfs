class GroupObject < DataFactory

  include Navigation
  include StringFactory
  include GlobalConfig

  attr_accessor :id, :namespace, :name, :type,
                :principal_name, :assignees

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:        'Default',
      namespace:   'KFS-AR - Accounts Receivable',
      name:        random_alphanums,
      assignees:   collection('GrAssignees')
    }

    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_GROUP)).merge(opts))
  end

  def create
    visit(AdministrationPage).group
    on(GroupLookupPage).create_new
    on GroupPage do |page|
      page.description.set random_alphanums
      @id=page.id
      fill_out page, :namespace, :name
      page.blanket_approve
    end
  end

  def add_assignee(opts={})
    view
    @assignees.add opts
  end

  def view
    visit(AdministrationPage).group
    on GroupLookupPage do |page|
      page.group_id.set @id
      page.search
      page.edit_item @name
    end
  end

  # =========
  private
  # =========



end