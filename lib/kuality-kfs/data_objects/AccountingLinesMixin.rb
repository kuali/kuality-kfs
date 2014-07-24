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
      @initial_lines.each{ |il| import_lines((il[:type].nil? ? :source : il[:type]), il[:file_name]) if il.has_key?(:file_name); }
      @initial_lines.delete_if{ |il| il.has_key?(:file_name) } # Remove all import initial lines
    end

    @initial_lines.each{ |il| add_line((il[:type].nil? ? :source : il[:type]), il) unless il.has_key?(:file_name); }
    @initial_lines.delete_if{ |il| !il.has_key?(:file_name) } # Remove all non-import initial lines

    # At the end of the method, we should either have either no remaining initial
    # lines, or (if @immediate_import is false) only file names of files to be imported at a later time
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

  # Import from any remaining initial lines.
  # @param [Symbol] type Import all lines of this type
  def import_initial_lines(type)
    @initial_lines.each do |initial_line|
      import_lines(type, initial_line[:file_name]) unless (initial_line[:type] != type ||
                                                           initial_line[:file_name].nil?)
    end
    @initial_lines.delete_if do |il|
      il.has_key?(:file_name) && il[:type] == type
    end # Remove all imported lines
  end

  # Import from a specific file
  # @param [Symbol] type Type of line to import
  # @param [String] file_name The name of the file to import, relative to the resources folder
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
        initial_lines:    [],
        immediate_import: true
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
        initial_lines:    [],
        immediate_import: true
    }.merge(opts)
  end

end
