module ItemAccountingLinesMixin

  attr_accessor :accounting_lines, :initial_lines

  def default_accounting_lines(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      accounting_lines: collection('ItemAccountingLineObject'),
      initial_lines:    []
    }.merge(opts)
  end

  def post_initialize
    @accounting_lines.parent = self # Necessary for initializing the cascading parent attribute
    super
  end

  def post_create
    super

    @initial_lines.each{ |il| add_line(il) unless il.has_key?(:file_name); }
    @initial_lines.delete_if{ |il| !il.has_key?(:file_name) } # Remove all non-import initial lines

    # At the end of the method, we should either have either no remaining initial lines
  end

  def add_line(al)
    @accounting_lines.add(al)
  end

end