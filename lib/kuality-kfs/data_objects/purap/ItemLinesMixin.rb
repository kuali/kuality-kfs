module ItemLinesMixin

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

  def post_create
    super
    import_initial_item_lines if @immediate_import

    @initial_item_lines.each{ |il| add_item_line( il ) unless il.has_key?(:file_name); }
    @initial_item_lines.delete_if{ |il| !il.has_key?(:file_name) } # Remove all non-import initial lines

    # At the end of the method, we should either have either no remaining initial
    # lines, or (if @immediate_import is false) only file names of files to be imported at a later time
  end

  def add_item_line(al)
    @items.add al
  end

  # Import from any remaining initial lines.
  def import_initial_item_lines
    @initial_item_lines.each { |initial_line| import_item_lines(initial_line[:file_name]) unless initial_line[:file_name].nil? }
    @initial_item_lines.delete_if { |il| il.has_key?(:file_name) } # Remove all imported lines
  end

  # Import from a specific file
  # @param [String] file_name The name of the file to import, relative to the resources folder
  def import_item_lines(file_name)
    @items.import_item_lines(file_name)
  end

end