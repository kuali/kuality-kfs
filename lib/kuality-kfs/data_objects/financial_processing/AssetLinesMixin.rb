module CapitalAssetLinesMixin

  attr_accessor :assets, :initial_assets

  def default_assets(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        assets:         collection('CapitalAssetLineObject'),
        initial_assets: [ Hash.new ]
    }.merge(opts)
  end

  def post_create
    super
    @initial_assets.each{ |il| @assets.add il }
    @initial_assets = nil
  end

  def update_line_objects_from_page!(target=:new)
    @assets.update_from_page! target
    super
  end

end