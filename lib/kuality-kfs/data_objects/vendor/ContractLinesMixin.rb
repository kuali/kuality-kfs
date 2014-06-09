module ContractLinesMixin

  attr_accessor :contracts, :initial_contracts

  def default_contracts(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      contracts:         collection('ContractLineObject'),
      initial_contracts: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_contracts.each{ |il| @contracts.add il }
    @initial_contracts = nil
  end

  def update_line_objects_from_page!(target=:new)
    @contracts.update_from_page! target
    super
  end

end