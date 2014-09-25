module ProjectDirectorLinesMixin

  attr_accessor :project_directors, :initial_project_directors

  def default_project_directors(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        project_directors:         collection('ProjectDirectorLineObject'),
        initial_project_directors: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_project_directors.each{ |il| @project_directors.add il }
    @initial_project_directors = nil
  end

  def update_line_objects_from_page!(target=:new)
    @organizations.update_from_page! target
    super
  end
  def add_project_director_line(il)
    @project_directors.add il.merge( { line_number: @project_directors.length } )
  end

end
