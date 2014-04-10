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

class VoucherLineObjectCollection < AccountingLineObjectCollection

  contains VoucherLineObject

  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_existing_line_values(type, i)
    on AccountingLine do |lines|
      super.merge({
                    amount: (lines.update_amount(type, i).value if lines.update_amount(type, i).exists?),
                    debit:  (lines.update_debit(type, i).value  if lines.update_debit(type, i).exists?)
                  })
           .merge(pull_voucher_extended_existing_line_values(type, i))
    end
  end

  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_voucher_extended_existing_line_values(type, i)
    # This can be implemented for site-specific attributes particular to the VoucherLineObject.
    # See the Hash returned in the #collect! in #update_from_page! above for the kind of way
    # to get the right return value.
    Hash.new
  end
end