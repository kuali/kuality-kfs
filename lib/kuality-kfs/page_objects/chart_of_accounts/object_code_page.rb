class ObjectCodePage < KFSBasePage

  element(:fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.universityFiscalYear') }
  element(:new_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.chartOfAccountsCode') }

  element(:object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCode') } #editable text field
  value(:object_code_value) { |b| b.frm.span(id: "document.newMaintainableObject.financialObjectCode.div") } #non-editable text displayed for value
  element(:object_code_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeName') }
  element(:object_code_short_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeShortName') }

  element(:reports_to_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reportsToFinancialObjectCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectTypeCode') }
  element(:level_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectLevelCode') }
  element(:object_sub_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectSubTypeCode') }

  #CU item
  element(:suny_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.sunyObjectCode') }

  element(:financial_object_code_description) { |b| b.frm.textarea(name: 'document.newMaintainableObject.extension.financialObjectCodeDescr') }
  element(:cg_reporting_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.cgReportingCode') }
  element(:historical_financial_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.historicalFinancialObjectCode') }
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  element(:budget_aggregation_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialBudgetAggregationCd') }

  element(:mandatory_transfer) { |b| b.frm.select(name: 'document.newMaintainableObject.finObjMandatoryTrnfrelimCd') }

  element(:federal_funded_code) { |b| b.frm.select(name: 'document.newMaintainableObject.financialFederalFundedCode') }
  element(:next_year_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.nextYearFinancialObjectCode') }

  #DOCUMENT
  action(:search_reports_to_object_code) { |b| b.frm.button(alt: 'Search Reports To Object Code').click }


end