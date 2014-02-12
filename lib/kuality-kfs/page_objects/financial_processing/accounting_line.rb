class AccountingLine < FinancialProcessingPage

  accounting_lines
  accounting_lines_from_to

  action(:result_from_chart_code) { |i, b| b.result_chart_code(from_to_map(:from), i, b) }
  action(:result_from_account_number) { |i, b| b.result_account_number(from_to_map(:from), i, b) }
  action(:result_from_sub_account_code) { |i, b| b.result_sub_account_code(from_to_map(:from), i, b) }
  action(:result_from_object_code) { |i, b| b.result_object_code(from_to_map(:from), i, b) }
  action(:result_from_sub_object_code) { |i, b| b.result_sub_object_code(from_to_map(:from), i, b) }
  action(:result_from_project_code) { |i, b| b.result_project_code(from_to_map(:from), i, b) }
  action(:result_from_organization_reference_id) { |i, b| b.result_organization_reference_id(from_to_map(:from), i, b) }
  action(:result_from_current_amount) { |i, b| b.result_current_amount(from_to_map(:from), i, b) }
  action(:result_from_base_amount) { |i, b| b.result_base_amount(from_to_map(:from), i, b) }
  action(:result_from_line_description) { |i, b| b.result_line_description(from_to_map(:from), i, b) }
  action(:result_from_reference_origin_code) { |i, b| b.result_reference_origin_code(from_to_map(:from), i, b) }
  action(:result_from_reference_number) { |i, b| b.result_reference_number(from_to_map(:from), i, b) }
  action(:result_from_amount) { |i, b| b.result_amount(from_to_map(:from), i, b) }

  action(:result_from_month_1) { |i, b| b.result_month_1(from_to_map(:from), i, b) }
  action(:result_from_month_2) { |i, b| b.result_month_2(from_to_map(:from), i, b) }
  action(:result_from_month_3) { |i, b| b.result_month_3(from_to_map(:from), i, b) }
  action(:result_from_month_4) { |i, b| b.result_month_4(from_to_map(:from), i, b) }
  action(:result_from_month_5) { |i, b| b.result_month_5(from_to_map(:from), i, b) }
  action(:result_from_month_6) { |i, b| b.result_month_6(from_to_map(:from), i, b) }
  action(:result_from_month_7) { |i, b| b.result_month_7(from_to_map(:from), i, b) }
  action(:result_from_month_8) { |i, b| b.result_month_8(from_to_map(:from), i, b) }
  action(:result_from_month_9) { |i, b| b.result_month_9(from_to_map(:from), i, b) }
  action(:result_from_month_10) { |i, b| b.result_month_10(from_to_map(:from), i, b) }
  action(:result_from_month_11) { |i, b| b.result_month_11(from_to_map(:from), i, b) }
  action(:result_from_month_12) { |i, b| b.result_month_12(from_to_map(:from), i, b) }

  action(:result_to_chart_code) { |i, b| b.result_chart_code(from_to_map(:to), i, b) }
  action(:result_to_account_number) { |i, b| b.result_account_number(from_to_map(:to), i, b) }
  action(:result_to_sub_account_code) { |i, b| b.result_sub_account_code(from_to_map(:to), i, b) }
  action(:result_to_object_code) { |i, b| b.result_object_code(from_to_map(:to), i, b) }
  action(:result_to_sub_object_code) { |i, b| b.result_sub_object_code(from_to_map(:to), i, b) }
  action(:result_to_project_code) { |i, b| b.result_project_code(from_to_map(:to), i, b) }
  action(:result_to_organization_reference_id) { |i, b| b.result_organization_reference_id(from_to_map(:to), i, b) }
  action(:result_to_current_amount) { |i, b| b.result_current_amount(from_to_map(:to), i, b) }
  action(:result_to_base_amount) { |i, b| b.result_base_amount(from_to_map(:to), i, b) }
  action(:result_to_line_description) { |i, b| b.result_line_description(from_to_map(:to), i, b) }
  action(:result_to_reference_origin_code) { |i, b| b.result_reference_origin_code(from_to_map(:to), i, b) }
  action(:result_to_reference_number) { |i, b| b.result_reference_number(from_to_map(:to), i, b) }
  action(:result_to_amount) { |i, b| b.result_amount(from_to_map(:to), i, b) }

  action(:result_to_month_1) { |i, b| b.result_month_1(from_to_map(:to), i, b) }
  action(:result_to_month_2) { |i, b| b.result_month_2(from_to_map(:to), i, b) }
  action(:result_to_month_3) { |i, b| b.result_month_3(from_to_map(:to), i, b) }
  action(:result_to_month_4) { |i, b| b.result_month_4(from_to_map(:to), i, b) }
  action(:result_to_month_5) { |i, b| b.result_month_5(from_to_map(:to), i, b) }
  action(:result_to_month_6) { |i, b| b.result_month_6(from_to_map(:to), i, b) }
  action(:result_to_month_7) { |i, b| b.result_month_7(from_to_map(:to), i, b) }
  action(:result_to_month_8) { |i, b| b.result_month_8(from_to_map(:to), i, b) }
  action(:result_to_month_9) { |i, b| b.result_month_9(from_to_map(:to), i, b) }
  action(:result_to_month_10) { |i, b| b.result_month_10(from_to_map(:to), i, b) }
  action(:result_to_month_11) { |i, b| b.result_month_11(from_to_map(:to), i, b) }
  action(:result_to_month_12) { |i, b| b.result_month_12(from_to_map(:to), i, b) }

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

  def self.from_to_map(mode)
    case mode
      when :from
        :source
      when :to
        :target
    end
  end

end
