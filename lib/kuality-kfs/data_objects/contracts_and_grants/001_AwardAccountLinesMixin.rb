module AwardAccountLinesMixin

  attr_accessor :award_accounts, :initial_award_accounts

  def default_award_accounts(opts={})
    # This just makes it so we don't have to be so repetitive. It can certainly be
    # overridden in a subclass if you don't want to chuck things in via opts.
    {
        award_accounts:         collection('AwardAccountLineObject'),
        initial_award_accounts: []
    }.merge(opts)
  end

  def post_create
    super
    @initial_award_accounts.each{ |il| @award_accounts.add il }
    @initial_award_accounts = nil
  end

  def update_line_objects_from_page!(target=:new)
    @award_accounts.update_from_page! target
    super
  end

  def add_award_account_line(il)
    @award_accounts.add il.merge( { line_number: @award_accounts.length } )
  end

end
