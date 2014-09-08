module SalaryExpenseTransferAccountingLinesMixin
  include AccountingLinesMixin
  extend AccountingLinesMixin

  def default_accounting_lines(opts={})
    {
        accounting_lines: {
            source: collection('SalaryExpenseTransferAccountingLineObject'),
            target: collection('SalaryExpenseTransferAccountingLineObject')
        },
        initial_lines:    [],
        immediate_import: true
    }.merge(opts)
  end
end