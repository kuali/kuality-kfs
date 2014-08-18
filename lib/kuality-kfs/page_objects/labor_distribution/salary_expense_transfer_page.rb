class SalaryExpenseTransferPage < FinancialProcessingPage

  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }
  element(:employee_id) { |b| b.frm.text_field(name: 'document.emplid') }
  action(:search_empl_id) { |b| b.frm.button(name: /^methodToCall.performLookup.\(!!org.kuali.rice.kim.api.identity.Person!!\)/m).click }
  action(:import_search) { |b| b.frm.button(title: 'search', name: /methodToCall.performBalanceInquiryLookup/m).click }

  action(:copy_all_source_accounting_lines) { |l=0, b| b.frm.button(name: 'methodToCall.copyAllAccountingLines').click }

  #returns the selected accounts from Ledger Balance Lookup for Salary Expense Transfer Document
  action(:return_selected) { |b| b.frm.button(id: /methodToCall.prepareToReturnSelectedResults/m).click }

  #Accounting Lines (READ-ONLY data elements)
  value(:chart_code_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].chartOfAccountsCode.div").text.strip }
  value(:account_number_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].accountNumber.div").text.strip }
  value(:sub_account_number_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].subAccountNumber.div").text.strip }
  value(:object_code_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].financialObjectCode.div").text.strip }
  value(:sub_object_code_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].financialSubObjectCode.div").text.strip }
  value(:project_code_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].projectCode.div").text.strip }
  value(:position_number_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].positionNumber.div").text.strip }
  value(:organization_reference_id_value) { |t='source', i=0, b| b.frm.span(id:  "document.#{t}AccountingLine[#{i}].organizationReferenceId.div").text.strip }
  value(:payroll_end_date_fiscal_year_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].payrollEndDateFiscalYear.div").text.strip }
  value(:payroll_end_date_fiscal_period_code_value) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].payrollEndDateFiscalPeriodCode.div").text.strip }
  #Accounting Lines (Editable data elements only on this page)
  value(:st_chart_code) { |t='target', i=0, b| b.frm.select(name: "document.#{t}AccountingLine[#{i}].chartOfAccountsCode").value}
  value(:st_account_number) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].accountNumber").value.strip }
  value(:st_sub_account_code) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].subAccountNumber").value.strip }
  value(:st_object_code) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialObjectCode").value.strip }
  value(:st_sub_object_code) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialSubObjectCode").value.strip }
  value(:st_project_code) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].projectCode").value.strip }
  value(:st_organization_reference_id) { |t='target', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].organizationReferenceId").value.strip }
  value(:st_payroll_total_hours) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].payrollTotalHours").value.strip }
  value(:st_amount) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].amount").value.strip }
  #Accounting Lines (Clickable link)
  action(:view_fringe_benefit_link) { |t='source', i=0, b| b.frm.span(id: "document.#{t}AccountingLine[#{i}].fringeBenefitView.div").link(href: /calculateFringeBenefit/) }

  #specify :source or :target when requesting count
  action(:accounting_lines_row_count) do |t, b|
    b.frm.div(id: 'tab-AccountingLines-div')
    .table(class: 'datatable')
    .elements(id: /document.#{t}AccountingLine(.*?)chartOfAccountsCode/).length # Should show up fairly consistently
  end

  accounting_lines   #nkk4 create SalaryExpenseTransferAccountingLine page that subclasses AccountingLine page. then only neeed to define additioanl elelments in SalaryExpenseTransferAccoutingLinesObject subclass
  labor_ledger_pending_entries

end