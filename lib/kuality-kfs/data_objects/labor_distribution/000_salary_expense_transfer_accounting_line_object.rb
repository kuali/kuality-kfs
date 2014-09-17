class SalaryExpenseTransferAccountingLineObject < AccountingLineObject

  attr_accessor :position_number, :payroll_end_date_fiscal_year, :payroll_end_date_fiscal_period_code,
                :payroll_total_hours, :fringe_benefit_inquiry

  # Currently, #create doesn't really interact with the page because items are
  # added to this collection through search pages; therefore, we are just
  # absorbing the new data from the page.
  def create
      on AccountingLine do |page|
        mappings = {
            "#{@type}_chart_code".to_sym                 => @chart_code,
            "#{@type}_account_number".to_sym             => @account_number,
            "#{@type}_sub_account_code".to_sym           => @sub_account,
            "#{@type}_sub_object_code".to_sym            => @sub_object,
            "#{@type}_project_code".to_sym               => @project,
            "#{@type}_organization_reference_id".to_sym  => @org_ref_id,
            "#{@type}_amount".to_sym                     => @amount,
        }
        mappings.merge!({"#{@type}_object_code".to_sym => @object}) unless @object.nil?
        mappings.merge!({"#{@type}_org_ref_id".to_sym => @org_ref_id}) unless @org_ref_id.nil?
        mappings.merge!({"#{@type}_position".to_sym => @position}) unless @position.nil?
        mappings.merge!({"#{@type}_pay_fiscal_year".to_sym => @pay_fiscal_year}) unless @pay_fiscal_year.nil?
        mappings.merge!({"#{@type}_pay_hours".to_sym => @pay_hours}) unless @pay_hours.nil?
        mappings.merge!({"#{@type}_fringe_benefit".to_sym => @fringe_benefit}) unless @fringe_benefit.nil?
        mappings.merge!(extended_create_mappings)

        fill_out_extended_attributes
      end
  end

  def extended_update_mappings
    mappings = Hash.new
    mappings.merge!({"update_#{@type}_org_ref_id".to_sym => opts[:org_ref_id]}) unless opts[:org_ref_id].nil?
    mappings.merge!({"update_#{@type}_position".to_sym => opts[:position]}) unless opts[:position].nil?
    mappings.merge!({"update_#{@type}_pay_fiscal_year".to_sym => opts[:pay_fiscal_year]}) unless opts[:pay_fiscal_year].nil?
    mappings.merge!({"update_#{@type}_pay_hours".to_sym => opts[:pay_hours]}) unless opts[:pay_hours].nil?
    mappings.merge!({"update_#{@type}_fringe_benefit".to_sym => opts[:fringe_benefit]}) unless opts[:fringe_benefit].nil?
    mappings
  end

end

class SalaryExpenseTransferAccountingLineObjectCollection < AccountingLineObjectCollection

  contains SalaryExpenseTransferAccountingLineObject

  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_existing_line_values(type, i)
    on AccountingLine do |lines|
      super.merge({
                      org_ref_id:       (lines.update_org_ref_id(type, i).value  if lines.update_org_ref_id(type, i).exists?),
                      position:         (lines.update_position(type, i).value  if lines.update_position(type, i).exists?),
                      pay_fiscal_year:  (lines.update_pay_fiscal_year(type, i).value  if lines.update_pay_fiscal_year(type, i).exists?),
                      pay_hours:        (lines.update_pay_hours(type, i).value  if lines.update_pay_hours(type, i).exists?),
                      fringe_benefit:   (lines.update_fringe_benefit(type, i).value  if lines.update_fringe_benefit5(type, i).exists?)
                  })
      .merge(pull_salary_expense_transfer_extended_existing_line_values(type, i))
    end
  end

  # @param [Symbol] type The type of line to import (source or target). You may want to use AccountingLineObject#get_type_conversion
  # @param [Fixnum] i The line number to look for (zero-based)
  def pull_salary_expense_transfer_extended_existing_line_values(type, i)
    # This can be implemented for site-specific attributes particular to the SalaryExpenseTransferAccountingLineObject.
    # See the Hash returned in the #collect! in #update_from_page! above for the kind of way
    # to get the right return value.
    Hash.new
  end

end
