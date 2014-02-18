class VoucherLineObject < AccountingLineObject

  attr_accessor   :debit, :credit

  def extended_create_mappings
    mappings = Hash.new
    mappings.merge!({"#{@type}_debit".to_sym => @debit}) unless @debit.nil?
    mappings.merge!({"#{@type}_credit".to_sym => @credit}) unless @credit.nil?
    mappings
  end

  def extended_update_mappings
    mappings = Hash.new
    mappings.merge!({"update_#{@type}_debit".to_sym => opts[:debit]}) unless opts[:debit].nil?
    mappings.merge!({"update_#{@type}_credit".to_sym => opts[:credit]}) unless opts[:credit].nil?
    mappings
  end

end

class VoucherLineObjectCollection < LineObjectCollection

  contains VoucherLineObject

end