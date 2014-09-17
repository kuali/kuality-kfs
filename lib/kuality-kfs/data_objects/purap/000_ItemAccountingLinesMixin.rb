module ItemAccountingLinesMixin

  # Include this mixin at the bottom of your class definition for best results.
  # Otherwise, the methods it extends may not be defined when the mixin is evaluated.
  # @param [Class] base_class Class that the mixin will be added to
  # @return [Class] Merged Class
  def self.included(base_class)
    base_class.class_eval do

      attr_accessor :accounting_lines, :initial_accounting_lines

      # Provides settings to use for setting defaults during initialization
      # @return [Hash] Default Accounting Lines settings to be used during initialization
      def default_item_accounting_lines(opts={})
        # This just makes it so we don't have to be so repetitive. It can certainly be
        # overridden in a subclass if you don't want to chuck things in via opts.
        {
          accounting_lines:         collection('ItemAccountingLineObject'),
          initial_accounting_lines: []
        }.merge(opts)
      end

      # Provides a shorthand way to add an Item Accounting Line to whatever
      # object this mixin is added to.
      # @param [Hash] al Accounting Line to add to the collection.
      def add_accounting_line(al)
        @accounting_lines.add al.merge( { parent: self.accounting_lines } )
        on(KFSBasePage).errors.should == []
      end

      # Note: If you're going to include this mixin in your class,
      # you'll need to provide implementations or stubs for these methods:

      # back up methods to be extended. Use these instead of #super in the extended methods
      alias_method :super_post_initialize, :post_initialize
      alias_method :super_post_create, :post_create

      # Actions to be performed at the end of #initialize
      def post_initialize
        @accounting_lines.parent = self # Necessary for initializing the cascading parent attribute
        super_post_initialize # We're calling #super after because setting the parent attribute first is very important.
      end

      # Actions to be performed at the end of #create, after all the fields have been
      # filled in (generally). At the end of the method, we should either have either
      # no remaining initial lines.
      def post_create
        super_post_create
        @initial_accounting_lines.each { |il| add_accounting_line il }
        @initial_accounting_lines.clear
      end
    end
  end

end