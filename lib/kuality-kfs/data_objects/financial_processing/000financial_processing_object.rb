class FinancialProcessingObject < KFSDataObject

  attr_accessor :accounting_lines,
                :accounting_lines_for_capitalization, :capital_assets,
                :from_chart_code, :from_account_number, :from_object_code, :from_current_amount,
                :to_chart_code, :to_object_code, :to_current_amount,
                :general_ledger_pending_entries

  @@skip_default_accounting_lines = false

  def skip_default_accounting_lines
    @@skip_default_accounting_lines = true
  end

end