class ObjectCodeLookupPage < Lookups

  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:chart_code) { |b| b.frm.select(name: 'chartOfAccountsCode') }

  element(:object_code) { |b| b.frm.text_field(name: 'financialObjectCode') }
  element(:object_code_name) { |b| b.frm.text_field(name: 'financialObjectCodeName') }
  element(:object_code_short_name) { |b| b.frm.text_field(name: 'financialObjectCodeShortName') }
  element(:level_code) { |b| b.frm.text_field(name: 'financialObjectLevelCode') }

  # This might be CU specific
  element(:cg_reporting_code) { |b| b.frm.text_field(name: 'extension.cgReportingCode') }

  element(:object_type_code) { |b| b.frm.text_field(name: 'financialObjectTypeCode') }
  element(:object_sub_type_code) { |b| b.frm.text_field(name: 'financialObjectSubTypeCode') }

  #CU Specific
  element(:suny_object_code) { |b| b.frm.text_field(name: 'extension.sunyObjectCode') }

  element(:financial_object_code_description) { |b| b.frm.text_field(name: 'extension.financialObjectCodeDescr') }
  element(:historical_financial_object_code) { |b| b.frm.text_field(name: 'historicalFinancialObjectCode') }
  element(:budget_aggregation_code) { |b| b.frm.text_field(name: 'financialBudgetAggregationCd') }

  element(:active_indicator_yes) { |b| b.frm.radio(id: 'activeYes') }
  element(:active_indicator_no) { |b| b.frm.radio(id: 'activeNo') }
  element(:active_indicator_both) { |b| b.frm.radio(id: 'activeBoth') }

end
