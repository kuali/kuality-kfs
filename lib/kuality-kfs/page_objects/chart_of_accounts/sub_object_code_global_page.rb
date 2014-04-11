class SubObjectCodeGlobalPage < KFSBasePage

  organization_facets

  #New section
  element(:new_fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.universityFiscalYear') }
  element(:new_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:new_sub_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialSubObjectCode') }
  element(:new_sub_object_code_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialSubObjectCodeName') }
  element(:new_sub_object_code_short_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialSubObjectCodeShortName') }

  #New Object Code section
  element(:noc_fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.subObjCdGlobalDetails.universityFiscalYear') }
  element(:noc_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.subObjCdGlobalDetails.chartOfAccountsCode') }
  element(:noc_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.subObjCdGlobalDetails.financialObjectCode') }

  #Edit Account section

  element(:na_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.accountGlobalDetails.chartOfAccountsCode') }
  element(:na_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.accountGlobalDetails.accountNumber') }

  action(:na_add_account) { |b| b.frm.button(name: 'methodToCall.addLine.accountGlobalDetails.(!!org.kuali.kfs.coa.businessobject.AccountGlobalDetail!!)').click }

  action(:add_multiple_account_lines) { |b| b.frm.button(title: 'Multiple Value Search on Account').click }
  #Using this to verify account numbers were added when user adds multiple account lines
  element(:verify_account_number) { |chart_code=get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE), account_number, b| b.frm.link(title: "show inquiry for Account Chart Code=#{chart_code} Account Number=#{account_number} ") }
end