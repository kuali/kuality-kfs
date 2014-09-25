module CapitalAssetLocationLinesMixin

  # Include this mixin at the bottom of your class definition for best results.
  # Otherwise, the methods it extends may not be defined when the mixin is evaluated.
  def self.included mixin
    mixin.class_eval do

      attr_accessor :asset_location_lines, :initial_lines

      # Provides settings to use for setting defaults during initialization
      # @return [Hash] Default Asset Location Lines settings to be used during initialization
      def default_asset_location_lines(opts={})
        # This just makes it so we don't have to be so repetitive. It can certainly be
        # overridden in a subclass if you don't want to chuck things in via opts.
        {
            asset_location_lines: collection('CapitalAssetLocationLineObject'),
            initial_lines:    []
        }.merge(opts)
      end

      # Provides a shorthand way to add an Asset Location Line to whatever
      # object this mixin is added to.
      # @param [Hash] al Asset Location to add to the collection.
      def add_line(al)
        @asset_location_lines.add al.merge!({parent: self.asset_location_lines})
      end

      # Note: If you're going to include this mixin in your class,
      # you'll need to provide implementations or stubs for these methods:

      # back up methods to be extended. Use these instead of #super in the extended methods
      alias_method :super_post_initialize, :post_initialize
      alias_method :super_post_create, :post_create

      # Actions to be performed at the end of #initialize
      def post_initialize
        @asset_location_lines.parent = self # Necessary for initializing the cascading parent attribute
        super_post_initialize # We're calling #super after because setting the parent attribute first is very important.
      end

      # Actions to be performed at the end of #create, after all the fields have been
      # filled in (generally). At the end of the method, we should either have either
      # no remaining initial lines.
      def post_create
        super_post_create
        @initial_lines.each{ |il| add_line il }
        @initial_lines.clear
      end

    end
  end

end