class CreditCardReceiptLineObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor   :line_number,
                  :type, :vendor_number, :date, :ref_nbr, :amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:             'VM',
      vendor_number:    '8008384516',
      date:             right_now[:date_w_slashes],
      ref_nbr:          '1234',
      amount:           '100'
    }

    set_options(defaults.merge(opts))
  end

  def create
    on CreditCardReceiptLine do |line|
      fill_out line, :type, :vendor_number, :date, :ref_nbr, :amount

      fill_out_extended_attributes
      line.add_credit_card_receipt_line
    end
  end

  def edit(opts = {})

    on CreditCardReceiptLine do |line|
      mappings = {
          update_type:             opts[:type],
          update_vendor_number:    opts[:vendor_number],
          update_date:             opts[:date],
          update_ref_nbr:          opts[:ref_nbr],
          update_amount:           opts[:amount]
      }
      mappings.merge!(extended_update_mappings)

      mappings.each do |field, value|
        lmnt = page.send(*[field, nil].compact, @line_number)
        var = value.nil? ? instance_variable_get("@#{field}") : value
        lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
      end

      edit_extended_attributes
      line.add_credit_card_receipt_line
    end
    update_options(opts)
  end

  def delete
    on(CreditCardReceiptLine).delete_credit_card_receipt_line(@line_number)
  end

  def extended_create_mappings
    # This needs to return a hash of additional mappings used for create
    Hash.new
  end

  def extended_update_mappings
    # This needs to return a hash of additional mappings used for update
    Hash.new
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  def edit_extended_attributes
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

end

class CreditCardReceiptLineObjectCollection < LineObjectCollection

  contains CreditCardReceiptLineObject

end