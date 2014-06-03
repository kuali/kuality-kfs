module AddressLinesMixin

  attr_accessor :addresses, :initial_addresses

  def default_addresses(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      addresses:         collection('AddressLineObject'),
      initial_addresses: [ Hash.new ] # Just throw in one Address with the default values, unless told otherwise
    }.merge(opts)
  end

  def post_create
    super
    @initial_addresses.each{ |il| @addresses.add il }
    @initial_addresses = nil
  end

  def update_line_objects_from_page!(target=:new)
    @addresses.update_from_page! target
    super
  end

end