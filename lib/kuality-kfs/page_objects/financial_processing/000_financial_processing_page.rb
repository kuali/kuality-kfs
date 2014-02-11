class FinancialProcessingPage < KFSBasePage


  class << self

    def document_overview
      element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
      element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
    end

    def financial_document_detail
      value(:fdd_total_amount) { |b| b.frm.table(summary: 'KFS Detail Section').td(align: 'left').text }
    end


    def accounting_lines
      element(:account_chart) { |b| b.frm.text_field(name: 'newSourceLine.chartOfAccountsCode') }
      element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
      element(:sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
      element(:object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
      element(:sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
      element(:project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
      element(:org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
      element(:amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
      element(:line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }

      action(:add_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
    end

    def accounting_lines_from_to
      #ACCOUNTING LINES FROM/DECREASE
      element(:from_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
      element(:from_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
      element(:from_sub_account_code) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
      element(:from_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
      element(:from_sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
      element(:from_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
      element(:from_organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
      element(:from_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
      element(:from_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }
      element(:from_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
      element(:from_reference_origin_code) { |b| b.frm.text_field(name: 'newSourceLine.referenceOriginCode') }
      element(:from_reference_number) { |b| b.frm.text_field(name: 'newSourceLine.referenceNumber') }
      element(:from_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
      element(:from_account_expired_override) { |b| b.frm.checkbox(name: 'newSourceLine.accountExpiredOverride') }

      action(:update_from_chart_code) { |i, b| b.frm.select(name: "document.sourceAccountingLine[#{i}].chartOfAccountsCode") }
      action(:update_from_account_number) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].accountNumber") }
      action(:update_from_sub_account_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].subAccountNumber") }
      action(:update_from_object_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialObjectCode") }
      action(:update_from_sub_object_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialSubObjectCode") }
      action(:update_from_project_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].projectCode") }
      action(:update_from_organization_reference_id) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].organizationReferenceId") }
      action(:update_from_current_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].currentBudgetAdjustmentAmount") }
      action(:update_from_base_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].baseBudgetAdjustmentAmount") }
      action(:update_from_line_description) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentLineDescription") }
      action(:update_from_reference_origin_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].referenceOriginCode") }
      action(:update_from_reference_number) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].referenceNumber") }
      action(:update_from_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].amount") }
      action(:update_from_account_expired_override) { |i, b| b.frm.checkbox(name: "document.sourceAccountingLine[#{i}].accountExpiredOverride") }

      element(:from_month_1) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth1LineAmount') }
      element(:from_month_2) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth2LineAmount') }
      element(:from_month_3) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth3LineAmount') }
      element(:from_month_4) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth4LineAmount') }
      element(:from_month_5) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth5LineAmount') }
      element(:from_month_6) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth6LineAmount') }
      element(:from_month_7) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth7LineAmount') }
      element(:from_month_8) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth8LineAmount') }
      element(:from_month_9) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth9LineAmount') }
      element(:from_month_10) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth10LineAmount') }
      element(:from_month_11) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth11LineAmount') }
      element(:from_month_12) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth12LineAmount') }

      action(:update_from_month_1) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth1LineAmount") }
      action(:update_from_month_2) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth2LineAmount") }
      action(:update_from_month_3) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth3LineAmount") }
      action(:update_from_month_4) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth4LineAmount") }
      action(:update_from_month_5) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth5LineAmount") }
      action(:update_from_month_6) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth6LineAmount") }
      action(:update_from_month_7) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth7LineAmount") }
      action(:update_from_month_8) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth8LineAmount") }
      action(:update_from_month_9) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth9LineAmount") }
      action(:update_from_month_10) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth10LineAmount") }
      action(:update_from_month_11) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth11LineAmount") }
      action(:update_from_month_12) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth12LineAmount") }

      action(:add_from_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
      action(:delete_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteSourceLine.line#{l}.anchoraccountingSourceAnchor").click }
      action(:balance_inquiry_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForSourceLine.line#{l}.anchoraccountingSourceexistingLineLineAnchor#{l}").click }
      action(:refresh_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingSourceAnchor").click }

      #ACCOUNTING LINES TO/INCREASE
      element(:to_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }
      element(:to_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
      element(:to_sub_account_code) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
      element(:to_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
      element(:to_sub_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
      element(:to_project_code) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
      element(:to_organization_reference_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
      element(:to_current_amount) { |b| b.frm.text_field(name: 'newTargetLine.currentBudgetAdjustmentAmount') }
      element(:to_base_amount) { |b| b.frm.text_field(name: 'newTargetLine.baseBudgetAdjustmentAmount') }
      element(:to_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }
      element(:to_reference_origin_code) { |b| b.frm.text_field(name: 'newTargetLine.referenceOriginCode') }
      element(:to_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }
      element(:to_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
      element(:to_account_expired_override) { |b| b.frm.checkbox(name: 'newTargetLine.accountExpiredOverride') }

      action(:update_to_chart_code) { |i, b| b.frm.select(name: "document.targetAccountingLine[#{i}].chartOfAccountsCode") }
      action(:update_to_account_number) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].accountNumber") }
      action(:update_to_sub_account_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].subAccountNumber") }
      action(:update_to_object_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialObjectCode") }
      action(:update_to_sub_object_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialSubObjectCode") }
      action(:update_to_project_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].projectCode") }
      action(:update_to_organization_reference_id) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].organizationReferenceId") }
      action(:update_to_current_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].currentBudgetAdjustmentAmount") }
      action(:update_to_base_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].baseBudgetAdjustmentAmount") }
      action(:update_to_line_description) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentLineDescription") }
      action(:update_to_reference_origin_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].referenceOriginCode") }
      action(:update_to_reference_number) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].referenceNumber") }
      action(:update_to_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].amount") }
      action(:update_to_account_expired_override) { |i, b| b.frm.checkbox(name: "document.targetAccountingLine[#{i}].accountExpiredOverride") }

      element(:to_month_1) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth1LineAmount') }
      element(:to_month_2) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth2LineAmount') }
      element(:to_month_3) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth3LineAmount') }
      element(:to_month_4) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth4LineAmount') }
      element(:to_month_5) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth5LineAmount') }
      element(:to_month_6) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth6LineAmount') }
      element(:to_month_7) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth7LineAmount') }
      element(:to_month_8) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth8LineAmount') }
      element(:to_month_9) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth9LineAmount') }
      element(:to_month_10) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth10LineAmount') }
      element(:to_month_11) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth11LineAmount') }
      element(:to_month_12) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth12LineAmount') }

      action(:update_to_month_1) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth1LineAmount") }
      action(:update_to_month_2) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth2LineAmount") }
      action(:update_to_month_3) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth3LineAmount") }
      action(:update_to_month_4) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth4LineAmount") }
      action(:update_to_month_5) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth5LineAmount") }
      action(:update_to_month_6) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth6LineAmount") }
      action(:update_to_month_7) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth7LineAmount") }
      action(:update_to_month_8) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth8LineAmount") }
      action(:update_to_month_9) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth9LineAmount") }
      action(:update_to_month_10) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth10LineAmount") }
      action(:update_to_month_11) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth11LineAmount") }
      action(:update_to_month_12) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth12LineAmount") }

      action(:add_to_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }
      action(:delete_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteTargetLine.line#{l}.anchoraccountingTargetAnchor").click }
      action(:balance_inquiry_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForTargetLine.line#{l}.anchoraccountingTargetexistingLineLineAnchor#{l}").click }
      action(:refresh_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingTargetAnchor").click }
    end


    def  accounting_lines_for_capitalization
            #on advanced deposit and general error correction

    end

    def create_capital_assets
      #on internal billing page
    end
    def modify_capital_assets
      #on advanced deposit and general error correction
    end

    def general_ledger_pending_entries
      #on every page.
    end

    def notes_and_attachments
      element(:note_text) { |b| b.frm.text_field(name: 'newNote.noteText') }
      action(:add_note) { |b| b.frm.button(title: 'Add a Note').click }
    end

    def ad_hoc_recipients
      element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
      element(:ad_hoc_person_action_requested) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
      action(:add_ad_hoc_person) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Person').click }
      #This is for one/multiple added person(s)
      action(:delete_ad_hoc_person) { |line_number='0', b| b.frm.button(name: 'methodToCall.deleteAdHocRoutePerson.line' + line_number).click}

      element(:ad_hoc_namespace_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
      element(:ad_hoc_name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }
      element(:ad_hoc_group_action_requested) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }
      action(:add_ad_hoc_group) { |b| b.frm.button(title: 'Insert Additional Ad Hoc Workgroup').click }
      #This is for one/multiple added group(s)
      action(:delete_ad_hoc_group) { |line_number='0', b| b.frm.button(name: 'methodToCall.deleteAdHocRouteWorkgroup.line'+ line_number).click}
    end

  end        #Self Class
end    #class
