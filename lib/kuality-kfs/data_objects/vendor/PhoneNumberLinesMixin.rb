module PhoneNumberLinesMixin

  attr_accessor :phone_numbers, :initial_phone_numbers

  def default_phone_numbers(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
      phone_numbers:         collection('PhoneLineObject'),
      initial_phone_numbers: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_phone_numbers.each{ |il| @phone_numbers.add il }
    @initial_phone_numbers = nil
  end

  def update_line_objects_from_page!(target=:new)
    @phone_numbers.update_from_page! target
    super
  end

end