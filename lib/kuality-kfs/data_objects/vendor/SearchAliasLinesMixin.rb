module SearchAliasLinesMixin

  attr_accessor :search_aliases, :initial_search_aliases

  def default_search_aliases(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      search_aliases:         collection('SearchAliasLineObject'),
      initial_search_aliases: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_search_aliases.each{ |il| @search_aliases.add il }
    @initial_search_aliases = nil
  end

  def update_line_objects_from_page!(target=:new)
    @search_aliases.update_from_page! target
    super
  end

end