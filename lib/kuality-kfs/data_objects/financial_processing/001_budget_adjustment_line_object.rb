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

class BudgetAdjustmentLineObjectCollection < LineObjectCollection

  contains BudgetAdjustmentLineObject

end