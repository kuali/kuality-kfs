class ObjectCodeGlobalPage < KFSBasePage

  element(:object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCode') }
  element(:object_code_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeName') }
  element(:object_code_short_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeShortName') }
  element(:reports_to_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reportsToFinancialObjectCode') }
  element(:object_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectTypeCode') }
  element(:level_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectLevelCode') }
  element(:cg_reporting_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.cgReportingCode') }
  element(:object_sub_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectSubTypeCode') }
  element(:suny_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.sunyObjectCode') }
  element(:financial_object_code_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialObjectCodeDescr') }
  element(:historical_financial_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.historicalFinancialObjectCode') }

  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.financialObjectActiveIndicator') }

  element(:budget_aggregation_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialBudgetAggregationCd') }

  element(:mandatory_transfer) { |b| b.frm.select(name: 'document.newMaintainableObject.finObjMandatoryTrnfrOrElimCd') }
  element(:federal_funded_code) { |b| b.frm.select(name: 'document.newMaintainableObject.financialFederalFundedCode') }

  element(:next_year_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.nextYearFinancialObjectCode') }

  element(:new_year_fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.objectCodeGlobalDetails.universityFiscalYear') }
  element(:new_year_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.objectCodeGlobalDetails.chartOfAccountsCode') }

  action(:add_multiple_chart_lines) { |b| b.frm.button(title: 'Multiple Value Search on Chart') }

  action(:add_chart_code) { |b| b.frm.button(name: 'methodToCall.addLine.objectCodeGlobalDetails.(!!org.kuali.kfs.coa.businessobject.ObjectCodeGlobalDetail!!).(:::;18;:::).anchor18').click }
end
