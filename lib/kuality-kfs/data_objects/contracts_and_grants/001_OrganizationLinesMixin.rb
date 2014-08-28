module OrganizationLinesMixin

  attr_accessor :organizations, :initial_organizations

  def default_organizations(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        organizations:         collection('OrganizationLineObject'),
        initial_organizations: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_organizations.each{ |il| @organizations.add il }
    @initial_organizations = nil
  end

  def update_line_objects_from_page!(target=:new)
    @organizations.update_from_page! target
    super
  end

  def add_organization_line(il)
    @organizations.add il.merge( { line_number: @organizations.length } )
  end

end
