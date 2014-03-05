class FinancialProcessingObject < KFSDataObject

  attr_accessor :accounting_lines,
                :accounting_lines_for_capitalization, :capital_assets,
                :from_chart_code, :from_account_number, :from_object_code, :from_current_amount, :from_base_amount, :from_line_description,
                :to_chart_code, :to_object_code, :to_current_amount, :to_base_amount, :to_line_description,
                :general_ledger_pending_entries,

                :new_account_number,:new_account_object_code, :new_account_amount, :add_accounting_line

                #:from_object_code_line_item

  #@@skip_default_accounting_lines = false
  #
  #def skip_default_accounting_lines
  #@add_accounting_line = false
  ## @skip_default_accounting_lines = true
  #end

end