class AccountingLineObject < DataObject

  attr_accessor   :line_number, :type,
                  :chart_code, :account_number, :sub_account, :object, :sub_object,
                  :project, :org_ref_id, :reference_origin_code, :reference_number,
                  :line_description, :amount, :base_amount, :current_amount,
                  :account_expired_override,
                  :file_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        chart_code:            'IT',
        line_description:      "Testing #{opts[:type]} Accounting Line"
    }

    set_options(defaults.merge(opts))
  end

  def create
    on AccountingLine do |page|
      mappings = {
          "#{@type}_chart_code".to_sym                 => @chart_code,
          "#{@type}_account_number".to_sym             => @account_number,
          "#{@type}_sub_account_code".to_sym           => @sub_account,
          "#{@type}_sub_object_code".to_sym            => @sub_object,
          "#{@type}_project_code".to_sym               => @project,
          "#{@type}_organization_reference_id".to_sym  => @org_ref_id,
          "#{@type}_reference_origin_code".to_sym      => @reference_origin_code,
          "#{@type}_reference_number".to_sym           => @reference_number,
          "#{@type}_line_description".to_sym           => @line_description,
          "#{@type}_amount".to_sym                     => @amount,
          "#{@type}_current_amount".to_sym             => @current_amount
      }
      mappings.merge!({"#{@type}_base_amount".to_sym => @base_amount}) unless @base_amount.nil?
      mappings.merge!({"#{@type}_object_code".to_sym => @object}) unless @object.nil?
      mappings.merge!(extended_create_mappings)

      mappings.each do |field, value|
        lmnt = page.send(*[field, nil].compact)
        var = value.nil? ? instance_variable_get("@#{field}") : value
        lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
      end

      fill_out_extended_attributes
      page.send("add_#{@type}_accounting_line")
      unless @account_expired_override.nil?
        page.send("#{@type}_account_expired_override").set
        page.send("add_#{@type}_accounting_line")
      end
    end
  end

  def edit(opts = {})
    on AccountingLine do |page|
      mappings = {
          "update_#{@type}_chart_code".to_sym                 => opts[:chart_code],
          "update_#{@type}_account_number".to_sym             => opts[:account_number],
          "update_#{@type}_sub_account_code".to_sym           => opts[:sub_account],
          "update_#{@type}_sub_object_code".to_sym            => opts[:sub_object],
          "update_#{@type}_project_code".to_sym               => opts[:project],
          "update_#{@type}_organization_reference_id".to_sym  => opts[:org_ref_id],
          "update_#{@type}_reference_origin_code".to_sym      => opts[:reference_origin_code],
          "update_#{@type}_reference_number".to_sym           => opts[:reference_number],
          "update_#{@type}_line_description".to_sym           => opts[:line_description],
          "update_#{@type}_amount".to_sym                     => opts[:amount],
          "update_#{@type}_current_amount".to_sym             => opts[:current_amount]
      }
      mappings.merge!({"update_#{@type}_base_amount".to_sym => opts[:base_amount]}) unless opts[:base_amount].nil?
      mappings.merge!({"update_#{@type}_object_code".to_sym => opts[:object]}) unless opts[:object].nil?
      mappings.merge!(extended_update_mappings)

      mappings.each do |field, value|
        lmnt = page.send(*[field, nil].compact, @line_number)
        var = value.nil? ? instance_variable_get("@#{field}") : value
        lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
      end

      edit_extended_attributes
      page.send("refresh_#{@type}_accounting_line")
      unless @account_expired_override.nil?
        page.send("#{@type}_account_expired_override").set
        page.send("refresh_#{@type}_accounting_line")
      end
    end
    update_options(opts)
  end

  def delete
    on(AccountingLine).send("delete_#{@type}_accounting_line")
  end

  def import_lines
    on(AccountingLine) do |line|
      line.send("import_lines_#{@type}")
      line.send("account_line_#{@type}_file_name").set($file_folder+file_name)
      line.send("add_#{@type}_import")
    end
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

class AccountingLineObjectCollection < LineObjectCollection

  contains AccountingLineObject

end