class ItemAccountingLineObject < DataFactory

  include GlobalConfig

  attr_accessor   :line_number,
                  :parent,
                  :chart_code, :account_number, :sub_account_code,
                  :object_code, :sub_object_code, :project_code,
                  :organization_reference_id, :line_description, :percent,
                  :amount, :account_expired_override

  def defaults
    Hash.new
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ITEM_ACCOUNTING_LINES))
                        .merge(opts))
  end

  def create
    pre_create
    build
    fill_out_extended_attributes
    on(ItemsTab).add_item_accounting_line(@parent.parent.line_number)
    post_create
  end

  def edit(opts={})
    edit_attributes(opts)
    edit_extended_attributes(opts)
    update_options(opts)
  end

  def build
    do_mappings_fill({
      chart_code:                @chart_code,
      account_number:            @account_number,
      sub_account_code:          @sub_account_code,
      object_code:               @object_code,
      sub_object_code:           @sub_object_code,
      project_code:              @project_code,
      organization_reference_id: @organization_reference_id,
      line_description:          @line_description,
      percent:                   @percent,
      amount:                    @amount,
      account_expired_override:  @account_expired_override
    })
  end

  def edit_attributes(opts = {})
    do_mappings_fill({
      update_chart_code:                opts[:chart_code],
      update_account_number:            opts[:account_number],
      update_sub_account_code:          opts[:sub_account_code],
      update_object_code:               opts[:object_code],
      update_sub_object_code:           opts[:sub_object_code],
      update_project_code:              opts[:project_code],
      update_organization_reference_id: opts[:organization_reference_id],
      update_line_description:          opts[:line_description],
      update_percent:                   opts[:percent],
      update_amount:                    opts[:amount],
      update_account_expired_override:  opts[:account_expired_override]
    })
  end

  def delete
    on(ItemsTab).delete_item_accounting_line(@parent.parent.line_number, @line_number)
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  def edit_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  private

  def do_mappings_fill(mappings)
    mappings.each do |field, value|
      lmnt = page.send(*[field, @parent.parent.line_number].compact)
      var = value.nil? ? instance_variable_get("@#{field}") : value
      lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
    end
  end

end

class ItemAccountingLineObjectCollection < LineObjectCollection

  contains ItemAccountingLineObject

  attr_accessor :parent

  def update_from_page!
    on ItemsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      (0..(lines.current_accounting_line_count(@parent.line_number) - 1)).to_a.collect!{ |i|
        lines.pull_existing_line_values(i)
             .merge(pull_extended_existing_line_values(i))
             .merge({parent: self})
      }.each { |new_obj|
        # Update the stored lines
        self << (make contained_class, new_obj)
      }

    end
  end

  # @param [Fixnum] i The Accounting Line line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_existing_line_values(i) # TODO: ItemAccountingLineObjectCollection#pull_existing_line_values
    # This will need to utilize the value of @parent.line_number to get the right line info
    Hash.new
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_extended_existing_line_values(i)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end

# I need to finish off the custom ItemAccountingLine business.
# Then I'll need to get back to the Mixin and decide if that needs customization.
# Then I'll need to add #parent to the items collection (perhaps as part of a process of creating a Mixin for the Items tab itself)