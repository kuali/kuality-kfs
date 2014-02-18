class AccountingLineObject < DataObject

  attr_accessor   :line_number, :type,
                  :chart_code, :account_number, :sub_account, :object, :sub_object,
                  :project, :org_ref_id, :reference_origin_code, :reference_number,
                  :line_description, :amount, :base_amount, :current_amount,
                  :account_expired_override,
                  :file_name,
                  :debit, :credit,
                  :month_1, :month_2, :month_3, :month_4, :month_5, :month_6,
                  :month_7, :month_8, :month_9, :month_10, :month_11, :month_12

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
        "#{@type}_object_code".to_sym                => @object,
        "#{@type}_sub_object_code".to_sym            => @sub_object,
        "#{@type}_project_code".to_sym               => @project,
        "#{@type}_organization_reference_id".to_sym  => @org_ref_id,
        "#{@type}_reference_origin_code".to_sym      => @reference_origin_code,
        "#{@type}_reference_number".to_sym           => @reference_number,
        "#{@type}_line_description".to_sym           => @line_description,
        "#{@type}_amount".to_sym                     => @amount,
        "#{@type}_current_amount".to_sym             => @current_amount,
        "#{@type}_base_amount".to_sym                => @base_amount,
        "#{@type}_debit".to_sym                      => @debit,
        "#{@type}_credit".to_sym                     => @credit
      }
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

      begin
        mappings.each do |field, value|
          lmnt = page.send(*[field, nil].compact)
          var = value.nil? ? instance_variable_get("@#{field}") : value
          lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
        end
      rescue
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
          "update_#{@type}_object_code".to_sym                => opts[:object],
          "update_#{@type}_sub_object_code".to_sym            => opts[:sub_object],
          "update_#{@type}_project_code".to_sym               => opts[:project],
          "update_#{@type}_organization_reference_id".to_sym  => opts[:org_ref_id],
          "update_#{@type}_reference_origin_code".to_sym      => opts[:reference_origin_code],
          "update_#{@type}_reference_number".to_sym           => opts[:reference_number],
          "update_#{@type}_line_description".to_sym           => opts[:line_description],
          "update_#{@type}_amount".to_sym                     => opts[:amount],
          "update_#{@type}_current_amount".to_sym             => opts[:current_amount],
          "update_#{@type}_base_amount".to_sym                => opts[:base_amount],
          "update_#{@type}_debit".to_sym                      => opts[:debit],
          "update_#{@type}_credit".to_sym                     => opts[:credit]
      }
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

class AccountingLineObjectCollection < CollectionsFactory

  contains AccountingLineObject

  # This is a little hackish, but it makes it so that the line index
  # gets set when the line is added.
  def <<(x)
    x.line_number = size
    super(x)
  end

  # Call this whenever you do something to the collection that may change line numbers
  def update_line_numbers!
    each_with_index do |al, new_line_number|
      al.line_number = new_line_number
    end
  end

  # For now this is the only good way to remove lines.
  def delete_at(x)
    self[x].delete
    super(x)
    update_line_numbers!
  end

end