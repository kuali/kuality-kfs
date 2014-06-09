module ContactLinesMixin

  attr_accessor :contacts, :initial_contacts

  def default_contacts(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      contacts:         collection('ContactLineObject'),
      initial_contacts: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_contacts.each{ |il| @contacts.add il }
    @initial_contacts = nil
  end

  def update_line_objects_from_page!(target=:new)
    @contacts.update_from_page! target
    super
  end

end