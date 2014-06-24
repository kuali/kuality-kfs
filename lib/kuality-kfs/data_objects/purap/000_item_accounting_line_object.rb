class ItemAccountingLineObject < DataFactory

  include GlobalConfig

  attr_accessor   :line_number,
                  :parent,
                  :chart_code, :account_number, :sub_account_code,
                  :object_code, :sub_object_code, :project_code,
                  :organization_reference_id, :line_description, :percent,
                  :amount

  def defaults
    Hash.new
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ITEM_ACCOUNTING_LINES))
                        .merge(opts))
  end

  def pre_create; end

  def post_create; end

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
      amount:                    @amount
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
      update_amount:                    opts[:amount]
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
    on ItemsTab do |page|
      mappings.each do |field, value|
        lmnt = page.send(*[field, @parent.parent.line_number].compact)
        var = value.nil? ? instance_variable_get("@#{field}") : value
        lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
      end
    end
  end

end

class ItemAccountingLineObjectCollection < LineObjectCollection

  contains ItemAccountingLineObject

  attr_accessor :parent

  def update_from_page!(target=:new)
    on ItemsTab do |lines|
      clear # Drop any cached lines. More reliable than sorting out an array merge.

      (0..(lines.current_accounting_line_count(@parent.line_number) - 1)).to_a.collect!{ |i|
        lines.pull_existing_line_values(i, target)
             .merge(pull_extended_existing_line_values(i, target))
      }.each { |new_obj|
        # Update the stored lines
        self << (make contained_class, new_obj)
      }

    end
  end

  # @param [Fixnum] i The Accounting Line line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_existing_line_values(i=0, t=:new) # TODO: ItemAccountingLineObjectCollection#pull_existing_line_values
    # This will need to utilize the value of @parent.line_number to get the right line info
    pulled_item = {}
    on ItemsTab do |b|
      case t
        when :new
          pulled_item = {
            chart_code:                b.chart_code(i).selected_options.first.text.strip,
            account_number:            b.account_number(i).value.strip,
            sub_account_code:          b.sub_account_code(i).value.strip,
            object_code:               b.object_code(i).value.strip,
            sub_object_code:           b.sub_object_code(i).value.strip,
            project_code:              b.project_code(i).value.strip,
            organization_reference_id: b.organization_reference_id(i).value.strip,
            line_description:          b.line_description(i).value.strip,
            percent:                   b.percent(i).value.strip,
            amount:                    b.amount(i).value.strip
          }
        when :old
          pulled_item = {
            chart_code:                b.result_chart_code(i),
            account_number:            b.result_account_number(i),
            sub_account_code:          b.result_sub_account_code(i),
            object_code:               b.result_object_code(i),
            sub_object_code:           b.result_sub_object_code(i),
            project_code:              b.result_project_code(i),
            organization_reference_id: b.result_organization_reference_id(i),
            line_description:          b.result_line_description(i),
            percent:                   b.result_percent(i),
            amount:                    b.result_amount(i)
          }
        else
          raise ArgumentError, "The provided target (#{t.inspect}) is not supported yet!"
      end
    end
    pulled_item
  end

  # @param [Fixnum] i The line number to look for (zero-based)
  # @return [Hash] The return values of extended attributes for the given line
  def pull_extended_existing_line_values(i=0, t=:new)
    # This can be implemented for site-specific attributes. See the Hash returned in
    # the #collect! in #update_from_page! above for the kind of way to get the
    # right return value.
    Hash.new
  end

end