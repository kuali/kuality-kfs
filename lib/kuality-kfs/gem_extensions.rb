module Watir
  module Container
    def frm
      case
        when iframe(id: 'iframeportlet').exist?
          iframe(id: 'iframeportlet')
        when iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').exist?
          begin
            if iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').iframe(id: 'iframeportlet').exists?
              iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet').iframe(id: 'iframeportlet')
            else
              iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet')
            end
          rescue
            iframe(id: /easyXDM_default\d+_provider/).iframe(id: 'iframeportlet')
          end
        when iframe(id: /easyXDM_default\d+_provider/).exist?
          iframe(id: /easyXDM_default\d+_provider/)
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
    def header_row
      self[0]
    end

    # @return [Array] An array of associative keys matching the text of the Table#header_row.
    def header_keys
      header_row.cells.collect { |x| snake_case(x.text.strip).to_s.gsub(/^[_]*/, '').to_sym }
    end

    # @param [Symbol] key The key in the Table#header_row associated with the desired column.
    # @return [Fixnum] The index into the Table#header_row where the column first appears. May not work as desired if key is duplicated in the header row.
    def keyed_column_index(key)
      header_keys.index(key)
    end

    # @param [Fixnum] columnnumber The column to select
    # @return [Array] An array of TableCells with the content in the given column
    def column(columnnumber)
      (0..(self.trs.length-1)).collect{ |i| self[i][columnnumber] }
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

class Object
  # Convenience shorthand method for comparing against false, similar to #nil?
  def false?
    self == false
  end

  # Convenience shorthand method for comparing against true, similar to #nil?
  def true?
    self == true
  end
end

