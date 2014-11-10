module Watir
  module Container
    def frm
      case
        when iframe(id: 'iframeportlet').exists?
          iframe(id: 'iframeportlet')
        when iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').exists?
          begin
            if iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').iframe(id: 'iframeportlet').exists?
              iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').iframe(id: 'iframeportlet')
            else
              iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet')
            end
          rescue
            iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet')
          end
        when iframe(id: /easyXDM_default\d+_provider/).exists?
          iframe(id: /easyXDM_default\d+_provider/)
        when iframe(id: /iframe_\d+/).exists?
          iframe(id: /iframe_\d+/)
        else
          self
      end
    end
  end

  # Because of the unique way we
  # set up radio buttons in Coeus,
  # we can use this method in our
  # radio button definitions.
  class Radio
    def fit answer
      set unless answer==nil
    end
  end

  # It would be nice if fit tried both the value and
  # the text before giving up.
  class Select
    def fit(str_or_rx)
      if include?(str_or_rx)
        select_by :text, str_or_rx unless str_or_rx==nil
      else
        select_by :value, str_or_rx unless str_or_rx==nil
      end
    end
  end

  # Because we're focusing on watir-webdriver v0.6.4 for now, we don't have good column access.
  # These extensions should provide us with some of that capability until we are ready to update,
  # and "shouldn't" cause problems when we do.
  class Table

    # @return [TableRow] The first row of the Table. Hence, this may or may not be what you really want. It usually is, though.
    def header_row(actual_row=0)
      self[actual_row]
    end

    # @return [Array] An array of associative keys matching the text of the Table#header_row.
    def header_keys(actual_row=0)
      header_row(actual_row).cells.collect { |x|
        if x.text.empty?
          :checkboxes if x.checkbox.exists?
        else
          snake_case(x.text.strip).to_s.gsub(/^[_]*/, '').gsub(/[_]*$/, '').gsub(/_[_]+_/, '_').gsub(/:/,'').to_sym
        end
      }
    end

    # @param [Symbol] key The key in the Table#header_row associated with the desired column.
    # @return [Fixnum] The index into the Table#header_row where the column first appears. May not work as desired if key is duplicated in the header row.
    def keyed_column_index(key, actual_row=0)
      header_keys(actual_row).index(key)
    end

    # @param [Fixnum] columnnumber The column to select
    # @return [Array] An array of TableCells with the content in the given column
    def column(columnnumber)
      (0..(self.trs.length-1)).collect{ |i| self[i][columnnumber] }
    end

    def to_a
      trs[0..(trs.length - 1)].collect{ |row|
        row.cells
           .collect{ |col| col.text }
           .reject{ |col| col.empty? }
      }.reject{ |row| row.empty? }
    end

    # @return [TableRow] The first row in the table.
    def first
      self.trs.first
    end

    # @return [TableRowCollection] All rows in the table except the first one.
    def rest
      self.trs[1..(self.trs.length-1)]
    end
  end

  class TableRows

    # @return [TableRow] The first row in the table.
    def first
      self.trs.first
    end

    # @return [TableRowCollection] All rows in the table except the first one.
    def rest
      self.trs[1..(self.trs.length-1)]
    end
  end

  class TextFieldLocator

    def validate_element(element)
      if element.tag_name.downcase == 'textarea'
        warn "Locating textareas with '#text_field' is deprecated. Please, use '#textarea' method instead for element with id='#{element.attribute('id')}', class='#{element.attribute('class')}', name='#{element.attribute('name')}'"
      end
      super
    end

  end # TextFieldLocator

end

class Array
  # This adds a quick shorthand for 1..self.length.
  # @return [Array] All items in the Array except the first one.
  def rest
    f, *r = *self
    r
  end
end

class String

  # Compares against another string, ignoring spaces, tabs, and newlines.
  # @param [String] other The String to compare against. Could be another type of object, so long as it supplies #gsub
  # @return [TrueClass] Result of #eql? if the mentioned characters were removed from both objects in the comparison.
  def eql_ignoring_whitespace?(other)
    gsub(/[ \n\t]*/, '').eql?(other.gsub(/[ \n\t]*/, ''))
  end

end

class Hash
  def rekey(h)
    dup.rekey! h
  end

  def rekey!(h)
    h.each { |k, newk| store(newk, delete(k)) if has_key? k }
    self
  end

  def snake_case_key!
    key_update = Hash[keys.zip(collect{ |k, _| snake_case(k) })]
    rekey! key_update
  end

  def snake_case_key
    key_update = Hash[keys.zip(collect{ |k, _| snake_case(k) })]
    rekey key_update
  end
end

class Object
  # Convenience shorthand method for comparing against false, similar to #nil?
  def false?
    self == false
  end

  # Convenience shorthand method for comparing against true, similar to #nil?
  def true?
    self == true
  end

  # Convenience shorthand method for comparing against :set, similar to #nil?
  def set?
    self == :set
  end
end

class Class
  alias_method :attr_reader_without_tracking, :attr_reader
  def attr_reader(*names)
    attr_readers.concat(names)
    attr_reader_without_tracking(*names)
  end

  def attr_readers
    @attr_readers ||= [ ]
  end

  alias_method :attr_writer_without_tracking, :attr_writer
  def attr_writer(*names)
    attr_writers.concat(names)
    attr_writer_without_tracking(*names)
  end

  def attr_writers
    @attr_writers ||= [ ]
  end

  alias_method :attr_accessor_without_tracking, :attr_accessor
  def attr_accessor(*names)
    attr_readers.concat(names)
    attr_writers.concat(names)
    attr_accessor_without_tracking(*names)
  end

  def attributes
    @attr_readers & @attr_writers
  end
end

class Cucumber::Ast::Table
  def to_data_object_attr
    Hash[rows_hash.map{ |k, v| [StringFactory.damballa(k), (v == 'nil' ? nil : v)] }]
  end
end

