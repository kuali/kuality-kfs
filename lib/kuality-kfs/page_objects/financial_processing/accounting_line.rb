class AccountingLine < FinancialProcessingPage

  accounting_lines

  action(:result_source_chart_code) { |i=0, b| b.result_chart_code(:source, i, b) }
  action(:result_source_account_number) { |i=0, b| b.result_account_number(:source, i, b) }
  action(:result_source_sub_account_code) { |i=0, b| b.result_sub_account_code(:source, i, b) }
  action(:result_source_object_code) { |i=0, b| b.result_object_code(:source, i, b) }
  action(:result_source_sub_object_code) { |i=0, b| b.result_sub_object_code(:source, i, b) }
  action(:result_source_project_code) { |i=0, b| b.result_project_code(:source, i, b) }
  action(:result_source_organization_reference_id) { |i=0, b| b.result_organization_reference_id(:source, i, b) }
  action(:result_source_current_amount) { |i=0, b| b.result_current_amount(:source, i, b) }
  action(:result_source_base_amount) { |i=0, b| b.result_base_amount(:source, i, b) }
  action(:result_source_line_description) { |i=0, b| b.result_line_description(:source, i, b) }
  action(:result_source_reference_origin_code) { |i=0, b| b.result_reference_origin_code(:source, i, b) }
  action(:result_source_reference_number) { |i=0, b| b.result_reference_number(:source, i, b) }
  action(:result_source_amount) { |i=0, b| b.result_amount(:source, i, b) }

  action(:result_source_month_1) { |i=0, b| b.result_month_1(:source, i, b) }
  action(:result_source_month_2) { |i=0, b| b.result_month_2(:source, i, b) }
  action(:result_source_month_3) { |i=0, b| b.result_month_3(:source, i, b) }
  action(:result_source_month_4) { |i=0, b| b.result_month_4(:source, i, b) }
  action(:result_source_month_5) { |i=0, b| b.result_month_5(:source, i, b) }
  action(:result_source_month_6) { |i=0, b| b.result_month_6(:source, i, b) }
  action(:result_source_month_7) { |i=0, b| b.result_month_7(:source, i, b) }
  action(:result_source_month_8) { |i=0, b| b.result_month_8(:source, i, b) }
  action(:result_source_month_9) { |i=0, b| b.result_month_9(:source, i, b) }
  action(:result_source_month_10) { |i=0, b| b.result_month_10(:source, i, b) }
  action(:result_source_month_11) { |i=0, b| b.result_month_11(:source, i, b) }
  action(:result_source_month_12) { |i=0, b| b.result_month_12(:source, i, b) }

  action(:result_target_chart_code) { |i=0, b| b.result_chart_code(:target, i, b) }
  action(:result_target_account_number) { |i=0, b| b.result_account_number(:target, i, b) }
  action(:result_target_sub_account_code) { |i=0, b| b.result_sub_account_code(:target, i, b) }
  action(:result_target_object_code) { |i=0, b| b.result_object_code(:target, i, b) }
  action(:result_target_sub_object_code) { |i=0, b| b.result_sub_object_code(:target, i, b) }
  action(:result_target_project_code) { |i=0, b| b.result_project_code(:target, i, b) }
  action(:result_target_organization_reference_id) { |i=0, b| b.result_organization_reference_id(:target, i, b) }
  action(:result_target_current_amount) { |i=0, b| b.result_current_amount(:target, i, b) }
  action(:result_target_base_amount) { |i=0, b| b.result_base_amount(:target, i, b) }
  action(:result_target_line_description) { |i=0, b| b.result_line_description(:target, i, b) }
  action(:result_target_reference_origin_code) { |i=0, b| b.result_reference_origin_code(:target, i, b) }
  action(:result_target_reference_number) { |i=0, b| b.result_reference_number(:target, i, b) }
  action(:result_target_amount) { |i=0, b| b.result_amount(:target, i, b) }

  action(:result_target_month_1) { |i=0, b| b.result_month_1(:target, i, b) }
  action(:result_target_month_2) { |i=0, b| b.result_month_2(:target, i, b) }
  action(:result_target_month_3) { |i=0, b| b.result_month_3(:target, i, b) }
  action(:result_target_month_4) { |i=0, b| b.result_month_4(:target, i, b) }
  action(:result_target_month_5) { |i=0, b| b.result_month_5(:target, i, b) }
  action(:result_target_month_6) { |i=0, b| b.result_month_6(:target, i, b) }
  action(:result_target_month_7) { |i=0, b| b.result_month_7(:target, i, b) }
  action(:result_target_month_8) { |i=0, b| b.result_month_8(:target, i, b) }
  action(:result_target_month_9) { |i=0, b| b.result_month_9(:target, i, b) }
  action(:result_target_month_10) { |i=0, b| b.result_month_10(:target, i, b) }
  action(:result_target_month_11) { |i=0, b| b.result_month_11(:target, i, b) }
  action(:result_target_month_12) { |i=0, b| b.result_month_12(:target, i, b) }

  action(:result_chart_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].chartOfAccountsCode.div").text }
  action(:result_account_number) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].accountNumber.div").text }
  action(:result_sub_account_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].subAccountNumber.div").text }
  action(:result_object_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialObjectCode.div").text }
  action(:result_sub_object_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialSubObjectCode.div").text }
  action(:result_project_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].projectCode.div").text }
  action(:result_organization_reference_id) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].organizationReferenceId.div").text }
  action(:result_current_amount) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].currentBudgetAdjustmentAmount.div").text }
  action(:result_base_amount) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].baseBudgetAdjustmentAmount.div").text }
  action(:result_line_description) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentLineDescription.div").text }
  action(:result_reference_origin_code) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].referenceOriginCode.div").text }
  action(:result_reference_number) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].referenceNumber.div").text }
  action(:result_amount) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].amount.div").text }

  action(:result_month_1) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth1LineAmount.div").text }
  action(:result_month_2) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth2LineAmount.div").text }
  action(:result_month_3) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth3LineAmount.div").text }
  action(:result_month_4) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth4LineAmount.div").text }
  action(:result_month_5) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth5LineAmount.div").text }
  action(:result_month_6) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth6LineAmount.div").text }
  action(:result_month_7) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth7LineAmount.div").text }
  action(:result_month_8) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth8LineAmount.div").text }
  action(:result_month_9) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth9LineAmount.div").text }
  action(:result_month_10) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth10LineAmount.div").text }
  action(:result_month_11) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth11LineAmount.div").text }
  action(:result_month_12) { |m, i, b| b.span(id: "document.#{m}AccountingLine[#{i}].financialDocumentMonth12LineAmount.div").text }

  action(:current_line_count) do |b|
    b.frm.div(id: 'tab-AccountingLines-div')
         .table(class: 'datatable')
         .rows
         .collect { |row| row[0].text.to_i if (row[0].text.to_f.to_s == row[0].text || row[0].text.to_i.to_s == row[0].text) }
         .delete_if { |r| r.nil? }
         .sort
         .last
  end
end
