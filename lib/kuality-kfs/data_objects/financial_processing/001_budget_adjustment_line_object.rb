class BudgetAdjustmentLineObject < AccountingLineObject

  attr_accessor   :month_1, :month_2, :month_3, :month_4, :month_5, :month_6,
                  :month_7, :month_8, :month_9, :month_10, :month_11, :month_12

  def extended_create_mappings
    mappings = Hash.new
    mappings.merge!({"#{@type}_month_1".to_sym => @month_1}) unless @month_1.nil?
    mappings.merge!({"#{@type}_month_2".to_sym => @month_2}) unless @month_2.nil?
    mappings.merge!({"#{@type}_month_3".to_sym => @month_3}) unless @month_3.nil?
    mappings.merge!({"#{@type}_month_4".to_sym => @month_4}) unless @month_4.nil?
    mappings.merge!({"#{@type}_month_5".to_sym => @month_5}) unless @month_5.nil?
    mappings.merge!({"#{@type}_month_6".to_sym => @month_6}) unless @month_6.nil?
    mappings.merge!({"#{@type}_month_7".to_sym => @month_7}) unless @month_7.nil?
    mappings.merge!({"#{@type}_month_8".to_sym => @month_8}) unless @month_8.nil?
    mappings.merge!({"#{@type}_month_9".to_sym => @month_9}) unless @month_9.nil?
    mappings.merge!({"#{@type}_month_10".to_sym => @month_10}) unless @month_10.nil?
    mappings.merge!({"#{@type}_month_11".to_sym => @month_11}) unless @month_11.nil?
    mappings.merge!({"#{@type}_month_12".to_sym => @month_12}) unless @month_12.nil?
    mappings
  end

  def extended_update_mappings
    mappings = Hash.new
    mappings.merge!({"update_#{@type}_month_1".to_sym => opts[:month_1]}) unless opts[:month_1].nil?
    mappings.merge!({"update_#{@type}_month_2".to_sym => opts[:month_2]}) unless opts[:month_2].nil?
    mappings.merge!({"update_#{@type}_month_3".to_sym => opts[:month_3]}) unless opts[:month_3].nil?
    mappings.merge!({"update_#{@type}_month_4".to_sym => opts[:month_4]}) unless opts[:month_4].nil?
    mappings.merge!({"update_#{@type}_month_5".to_sym => opts[:month_5]}) unless opts[:month_5].nil?
    mappings.merge!({"update_#{@type}_month_6".to_sym => opts[:month_6]}) unless opts[:month_6].nil?
    mappings.merge!({"update_#{@type}_month_7".to_sym => opts[:month_7]}) unless opts[:month_7].nil?
    mappings.merge!({"update_#{@type}_month_8".to_sym => opts[:month_8]}) unless opts[:month_8].nil?
    mappings.merge!({"update_#{@type}_month_9".to_sym => opts[:month_9]}) unless opts[:month_9].nil?
    mappings.merge!({"update_#{@type}_month_10".to_sym => opts[:month_10]}) unless opts[:month_10].nil?
    mappings.merge!({"update_#{@type}_month_11".to_sym => opts[:month_11]}) unless opts[:month_11].nil?
    mappings.merge!({"update_#{@type}_month_12".to_sym => opts[:month_12]}) unless opts[:month_12].nil?
    mappings
  end

end

class BudgetAdjustmentLineObjectCollection < AccountingLineObjectCollection

  contains BudgetAdjustmentLineObject


  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_existing_line_values(type, i)
    on AccountingLine do |lines|
      super.merge({
                    month_1:  (lines.update_month_1(type, i).value  if lines.update_month_1(type, i).exists?),
                    month_2:  (lines.update_month_2(type, i).value  if lines.update_month_2(type, i).exists?),
                    month_3:  (lines.update_month_3(type, i).value  if lines.update_month_3(type, i).exists?),
                    month_4:  (lines.update_month_4(type, i).value  if lines.update_month_4(type, i).exists?),
                    month_5:  (lines.update_month_5(type, i).value  if lines.update_month_5(type, i).exists?),
                    month_6:  (lines.update_month_6(type, i).value  if lines.update_month_6(type, i).exists?),
                    month_7:  (lines.update_month_7(type, i).value  if lines.update_month_7(type, i).exists?),
                    month_8:  (lines.update_month_8(type, i).value  if lines.update_month_8(type, i).exists?),
                    month_9:  (lines.update_month_9(type, i).value  if lines.update_month_9(type, i).exists?),
                    month_10: (lines.update_month_10(type, i).value if lines.update_month_10(type, i).exists?),
                    month_11: (lines.update_month_11(type, i).value if lines.update_month_11(type, i).exists?),
                    month_12: (lines.update_month_12(type, i).value if lines.update_month_12(type, i).exists?)
                  })
      .merge(pull_budget_adjustment_extended_existing_line_values(type, i))
    end
  end

  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_budget_adjustment_extended_existing_line_values(type, i)
    # This can be implemented for site-specific attributes particular to the BudgetAdjustmentLineObject.
    # See the Hash returned in the #collect! in #update_from_page! above for the kind of way
    # to get the right return value.
    Hash.new
  end

end