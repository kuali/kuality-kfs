module AccountingLinesMixin

  attr_accessor :accounting_lines, :initial_lines, :immediate_import

  def default_accounting_lines(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        accounting_lines: {
            source: collection('AccountingLineObject'),
            target: collection('AccountingLineObject')
        },
        initial_lines:    [],
        immediate_import: true
    }.merge(opts)
  end

  def post_create
    super
    if @immediate_import
      @initial_lines.each{ |il| import_lines((il[:type].nil? ? :source : il[:type]), il) if il.has_key?(:file_name); }
      @initial_lines.delete_if{ |il| il.has_key?(:file_name) } # Remove all import initial lines
    end

    @initial_lines.each{ |il| add_line((il[:type].nil? ? :source : il[:type]), il) unless il.has_key?(:file_name); }
    @initial_lines.delete_if{ |il| !il.has_key?(:file_name) } # Remove all non-import initial lines
  end

  def add_line(type, al)
    @accounting_lines[type].add(al.merge({type: type}))
  end

  def add_target_line(al)
    add_line(:target, al)
  end

  def add_source_line(al)
    add_line(:source, al)
  end

  # This seems to be the best way to shorten the repeated information in the
  # import_lines method and makes the method call make more semantic sense.
  def import_lines(type, file_name)
    @accounting_lines[type].import_lines(type, file_name)
  end

  def import_source_lines(file_name)
    import_lines(:source, file_name)
  end

  def import_target_lines(file_name)
    import_lines(:target, file_name)
  end

end

module BudgetAdjustmentLinesMixin
  include AccountingLinesMixin
  extend AccountingLinesMixin

  def default_accounting_lines(opts={})
    {
        accounting_lines: {
            source: collection('BudgetAdjustmentLineObject'),
            target: collection('BudgetAdjustmentLineObject')
        },
        initial_lines:    []
    }.merge(opts)
  end

end

module VoucherLinesMixin
  include AccountingLinesMixin
  extend AccountingLinesMixin

  def default_accounting_lines(opts={})
    {
        accounting_lines: {
            source: collection('VoucherLineObject'),
            target: collection('VoucherLineObject')
        },
        initial_lines:    []
    }.merge(opts)
  end

end