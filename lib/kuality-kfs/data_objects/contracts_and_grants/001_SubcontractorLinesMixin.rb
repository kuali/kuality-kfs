module SubcontractorLinesMixin

  attr_accessor :subcontractors, :initial_subcontractors

  def default_subcontractors(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        subcontractors:         collection('SubcontractorLineObject'),
        initial_subcontractors: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_subcontractors.each{ |il| @subcontractors.add il }
    @initial_subcontractors = nil
  end

  def update_line_objects_from_page!(target=:new)
    @subcontractors.update_from_page! target
    super
  end

  def add_subcontractor_line(il)
    @subcontractors.add il.merge( { line_number: @subcontractors.length } )
  end

end
