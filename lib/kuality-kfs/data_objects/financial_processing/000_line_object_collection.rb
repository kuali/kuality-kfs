# If you're going to use this, your Line Object must implement the following methods:
#
# - line_number(FixNum)
# - delete(nil)
#
# where line_number is an attribute indicating the 0-based line index of the Object
# and delete performs any actions on the page required to remove the line.
class LineObjectCollection < CollectionsFactory

  include Foundry

  # This is a little hackish, but it makes it so that the line index
  # gets set when the line is added.
  def <<(lo)
    lo.line_number = size
    super(lo)
  end

  # Call this whenever you do something to the collection that may change line numbers
  def update_line_numbers!
    each_with_index do |lo, new_line_number|
      lo.line_number = new_line_number
    end
  end

  # For now this is the only good way to remove lines.
  def delete_at(line_number)
    self[line_number].delete
    super(line_number)
    update_line_numbers!
  end

  # Provides the line import button and makes it so you don't need to provide
  # a superfluous index to click the button.
  def import_lines(type, file_name)
    on(AccountingLine) do |line|
      line.send("import_lines_#{type}")
      line.send("account_line_#{type}_file_name").set($file_folder+file_name)
      line.send("add_#{type}_import")
    end
  end

  def import_source_lines(file_name)
    import_lines(:source, file_name)
  end

  def import_target_lines(file_name)
    import_lines(:target, file_name)
  end

end