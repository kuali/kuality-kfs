module ProcessItemsAccountingLinesMixin

  attr_accessor :additional_charges_accounting_lines,
                :initial_additional_charges

  def default_additional_charges_accounting_lines(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        additional_charges_accounting_lines: {
            freight:               collection('AccountingLineObject'),
            miscellaneous:         collection('AccountingLineObject'),
            shipping_and_handling: collection('AccountingLineObject')
        },
        initial_additional_charges:    [],
    }.merge(opts)
  end

  # Supply/override post_create hook to process Additional Charges that are supplied initially.
  def post_create
    super
    @initial_additional_charges.each{ |il| add_additional_charge_line(il[:type], il) }
    @initial_additional_charges.clear
  end

  # Simply adds a given Additional Charge accounting line.
  # @param [Symbol] section The section that the accounting lines are located in
  # @param [Hash] al The parameters to pass into the AccountingLineObject constructor
  def add_additional_charge_line(section, al)
    # Note that all of these lines are 'Source' lines...
    @additional_charges_accounting_lines[section].add(al.merge({type: :source}))
  end

  # Simply adds a given Additional Charge accounting line to the Freight section.
  # @param [Hash] al The parameters to pass into the AccountingLineObject constructor
  def add_freight_line(al)
    add_additional_charge_line(:freight, al)
  end

  # Simply adds a given Additional Charge accounting line to the Miscellaneous section.
  # @param [Hash] al The parameters to pass into the AccountingLineObject constructor
  def add_miscellaneous_line(al)
    add_additional_charge_line(:miscellaneous, al)
  end

  # Simply adds a given Additional Charge accounting line to the Shipping and Handling section.
  # @param [Hash] al The parameters to pass into the AccountingLineObject constructor
  def add_shipping_and_handling_line(al)
    add_additional_charge_line(:shipping_and_handling, al)
  end

end
