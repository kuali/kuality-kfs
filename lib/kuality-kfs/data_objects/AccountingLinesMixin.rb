module AccountingLinesMixin

  attr_accessor :accounting_lines, :initial_lines

  def default_lines(opts={})
    # This just makes it so don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      accounting_lines: {
        from: collection('AccountingLineObject'),
        to:   collection('AccountingLineObject')
      },
      initial_lines:    []
    }.merge(opts)
  end

  def post_create
    super
    @initial_lines.each{ |il| add_line((il[:target].nil? ? il[:target] : :from), il) }
  end

  def add_line(type, al)
    @accounting_lines[type].add(al.merge({target: type}))
  end

  def add_to_line(al)
    add_line(:to, al)
  end

  def add_from_line(al)
    add_line(:from, al)
  end

end
