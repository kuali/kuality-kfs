module ItemLinesMixin

  # Include this mixin at the bottom of your class definition for best results.
  # Otherwise, the methods it extends may not be defined when the mixin is evaluated.
  # @param [Class] base_class Class that the mixin will be added to
  # @return [Class] Merged Class
  def self.included(base_class)
    base_class.class_eval do

      attr_accessor :items, :initial_item_lines, :immediate_import

      def default_items(opts={})
        # This just makes it so we don't have to be so repetitive. It can certainly be
        # overridden in a subclass if you don't want to chuck things in via opts.
        {
          items:              collection('ItemLineObject'),
          initial_item_lines: [],
          immediate_import:   true
        }.merge(opts)
      end

      def process_initial_item_lines
        import_initial_item_lines if @immediate_import

        @initial_item_lines.each { |il| add_item_line( il.merge({line_number: @items.size}) ) unless il.has_key?(:file_name) }
        @initial_item_lines.delete_if { |il| !il.has_key?(:file_name) } # Remove all non-import initial lines

        # At the end of the method, we should either have either no remaining initial
        # lines, or (if @immediate_import is false) only file names of files to be imported at a later time
      end

      # Adds a single item to the item collection. Manually setting @line_number
      # for the new item is necessary when you have initial accounting lines for
      # the item because you need the Item line number to locate the Accounting
      # Lines' creation input line. Otherwise, having the line number set when
      # the item is added to the collection would be sufficient.
      # @param [Hash] il All the variable values for the item to be added to the collection
      def add_item_line(il)
        @items.add il.merge( { line_number: @items.length } )
      end

      # Import from any remaining initial lines.
      def import_initial_item_lines
        @initial_item_lines.each { |initial_line| import_item_lines(initial_line[:file_name]) unless initial_line[:file_name].nil? }
        @initial_item_lines.delete_if { |il| il.has_key?(:file_name) } # Remove all imported lines
      end

      # Import from a specific file
      # @param [String] file_name The name of the file to import, relative to the resources folder
      def import_item_lines(file_name)
        @items.import_item_lines file_name
      end

      # back up methods to be extended. Use these instead of #super in the extended methods
      alias_method :super_post_create, :post_create

      def post_create
        super_post_create
        process_initial_item_lines
      end

    end
  end

end