module AccountingLinesMixin

  attr_accessor :accounting_lines, :initial_lines

  def default_lines(opts={})
    # This just makes it so don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      accounting_lines: {
        source: collection('AccountingLineObject'),
        target: collection('AccountingLineObject')
      },
      initial_lines:    []
    }.merge(opts)
  end

  def post_create
    super
    @initial_lines.each{ |il| add_line((il[:type].nil? ? :source : il[:type]), il) }
  end

  def add_line(type, al)
    raise ArgumentError "No type provided for line #{al}!" if (type.nil? || type.empty?)
    @accounting_lines[type].add(al.merge({type: type}))
  end

  def add_target_line(al)
    add_line(:target, al)
  end

  def add_source_line(al)
    add_line(:source, al)
  end

end
