class IndirectCostRecoveryRatePage < KFSBasePage

  element(:fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.universityFiscalYear') }
  element(:rate_id) { |b| b.frm.text_field(name: 'document.newMaintainableObject.financialIcrSeriesIdentifier') }
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }


  #adjust both alias_methods and ternary method for readonly field widgets in a specific test
  alias_method :fiscal_year_readonly, :fiscal_year
  alias_method :rate_id_readonly, :rate_id
  alias_method :active_indicator_readonly, :active_indicator

  element(:fiscal_year_new) { |b| (b).fiscal_year.exists? ? b.fiscal_year.value.strip : b.fiscal_year_readonly.value.strip }
  element(:rate_id_new) { |b| (b).rate_id.exists? ? b.rate_id.value.strip : b.rate_id_readonly.value.strip }
  element(:active_indicator_new) { |b| (b).active_indicator.exists? ? b.active_indicator.value : b.active_indicator_readonly.value }


  # contains a single Indirect Cost Recovery Rate Detail Object that is going to be added on the page
  element(:icr_rate_detail_tab) { |b| b.frm.div(id: 'tab-EditIndirectCostRecoveryRates-div') }
  value(:current_icr_rate_detail_count) { |b| b.icr_rate_detail_tab.spans(class: 'left', text: /ICR Rate Detail [(]/m).length }

  element(:line_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.awardIndrCostRcvyEntryNbr.div') }  #has label ICR Entry Number
  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.financialObjectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.financialSubObjectCode') }
  element(:debit_credit_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.transactionDebitIndicator') }
  element(:percent) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.awardIndrCostRcvyRatePct') }
  element(:details_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.indirectCostRecoveryRateDetails.active') }
  action(:add_icr_rate_detail) { |b| b.frm.button(name: 'methodToCall.addLine.indirectCostRecoveryRateDetails.(!!org.kuali.kfs.coa.businessobject.IndirectCostRecoveryRateDetail!!).(:::;5;:::).anchor5').click }


  # single Indirect Cost Recovery Rate Detail Object that is on the page and cannot be changed.
  element(:line_number_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].awardIndrCostRcvyEntryNbr.div").text.strip } #has label ICR Entry Number
  element(:chart_code_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].chartOfAccountsCode.div").text.strip  }
  element(:account_number_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].accountNumber.div").text.strip  }
  element(:sub_account_number_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].subAccountNumber.div").text.strip  }
  element(:object_code_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].financialObjectCode.div").text.strip  }
  element(:sub_object_code_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].financialSubObjectCode.div").text.strip  }
  element(:debit_credit_code_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].transactionDebitIndicator.div").text.strip  }
  element(:percent_readonly) { |i=0, b| b.icr_rate_detail_tab.span(id: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].awardIndrCostRcvyRatePct.div").text.strip  }
  element(:details_active_indicator_readonly) { |i=0, b| b.icr_rate_detail_tab.checkbox(name: "document.newMaintainableObject.indirectCostRecoveryRateDetails[#{i}].active").value }

  #use alias methods until ternary methods needed for a specific test
  alias_method :line_number_new, :line_number_readonly
  alias_method :chart_code_new, :chart_code_readonly
  alias_method :account_number_new, :account_number_readonly
  alias_method :sub_account_number_new, :sub_account_number_readonly
  alias_method :object_code_new, :object_code_readonly
  alias_method :sub_object_code_new, :sub_object_code_readonly
  alias_method :debit_credit_code_new, :debit_credit_code_readonly
  alias_method :percent_new, :percent_readonly
  alias_method :details_active_indicator_new, :details_active_indicator_readonly

end