class InternalBillingPage < FinancialProcessingPage

  financial_document_detail
  accounting_lines

  accounting_lines_for_capitalization
  create_capital_assets
  modify_capital_assets
  ad_hoc_recipients

  #accounting_lines_income_expense
  #INCOME
  element(:income_chart) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:income_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:income_sub_account) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:income_object) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:income_sub_object) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:income_project) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:income_org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }

  element(:income_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
  element(:income_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }
  element(:income_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }

  #action(:add_income_accounting_line) { |b| b.frm.button(alt: 'Add Income Accounting Line').click }
  #EXPENSE
  element(:expense_chart) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:expense_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
  element(:expense_sub_account) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
  element(:expense_object) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
  element(:expense_sub_object) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
  element(:expense_project) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
  element(:expense_org_ref_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
  element(:expense_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
  element(:expense_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }

  #action(:add_expense_accounting_line) { |b| b.frm.button(alt: 'Add Expense Accounting Line').click }

#items
  element(:items_date) { |b| b.frm.text_field(name: 'newItem.itemServiceDate') }
  element(:items_stock_number) { |b| b.frm.text_field(name: 'newItem.itemStockNumber') }
  element(:items_description) { |b| b.frm.text_field(name: 'newItem.itemStockDescription') }
  element(:items_quantity) { |b| b.frm.text_field(name: 'newItem.itemQuantity') }
  element(:items_uom) { |b| b.frm.text_field(name: 'newItem.unitOfMeasureCode') }
  alias_method :items_unit_of_measure, :items_uom

  element(:item_cost) { |b| b.frm.text_field(name: 'newItem.itemUnitAmount') }
  alias_method :items_item_cost, :item_cost

  action(:add_item_line) { |b| b.frm.button(alt: 'Insert an Item').click }




end
