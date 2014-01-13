class ObjectCodePage < BasePage

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages

  element(:fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.universityFiscalYear') }
  element(:new_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.chartOfAccountsCode') }

  element(:object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCode') }
  element(:object_code_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeName') }
  element(:object_code_short_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeShortName') }

  element(:reports_to_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reportsToFinancialObjectCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectTypeCode') }
  element(:level_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectLevelCode') }
  element(:object_sub_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectSubTypeCode') }

  #CU item
  element(:suny_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.sunyObjectCode') }

  element(:financial_object_code_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.financialObjectCodeDescr') }
  element(:cg_reporting_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.cgReportingCode') }
  element(:historical_financial_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.historicalFinancialObjectCode') }
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  element(:budget_aggregation_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialBudgetAggregationCd') }

  element(:mandatory_transfer) { |b| b.frm.select(name: 'document.newMaintainableObject.finObjMandatoryTrnfrelimCd') }

  element(:federal_funded_code) { |b| b.frm.select(name: 'document.newMaintainableObject.financialFederalFundedCode') }
  element(:next_year_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.nextYearFinancialObjectCode') }

end