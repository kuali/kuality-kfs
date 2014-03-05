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
      element(:source_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
      element(:source_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
      element(:source_sub_account_code) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
      element(:source_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
      element(:source_sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
      element(:source_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
      element(:source_organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
      element(:source_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
      element(:source_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }
      element(:source_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
      element(:source_reference_origin_code) { |b| b.frm.text_field(name: 'newSourceLine.referenceOriginCode') }
      element(:source_reference_number) { |b| b.frm.text_field(name: 'newSourceLine.referenceNumber') }
      element(:source_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
      element(:source_debit) { |b| b.frm.text_field(name: 'newSourceLineDebit') }
      element(:source_credit) { |b| b.frm.text_field(name: 'newSourceLineCredit') }
      element(:source_account_expired_override) { |b| b.frm.checkbox(name: 'newSourceLine.accountExpiredOverride') }

      action(:update_source_chart_code) { |i, b| b.frm.select(name: "document.sourceAccountingLine[#{i}].chartOfAccountsCode") }
      action(:update_source_account_number) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].accountNumber") }
      action(:update_source_sub_account_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].subAccountNumber") }
      action(:update_source_object_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialObjectCode") }
      action(:update_source_sub_object_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialSubObjectCode") }
      action(:update_source_project_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].projectCode") }
      action(:update_source_organization_reference_id) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].organizationReferenceId") }
      action(:update_source_current_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].currentBudgetAdjustmentAmount") }
      action(:update_source_base_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].baseBudgetAdjustmentAmount") }
      action(:update_source_line_description) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentLineDescription") }
      action(:update_source_reference_origin_code) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].referenceOriginCode") }
      action(:update_source_reference_number) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].referenceNumber") }
      action(:update_source_amount) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].amount") }
      action(:update_source_debit) { |i, b| b.frm.text_field(name: "voucherLineHelper[#{i}].debit") }
      action(:update_source_credit) { |i, b| b.frm.text_field(name: "voucherLineHelper[#{i}].credit") }
      action(:update_source_account_expired_override) { |i, b| b.frm.checkbox(name: "document.sourceAccountingLine[#{i}].accountExpiredOverride") }

      element(:source_month_1) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth1LineAmount') }
      element(:source_month_2) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth2LineAmount') }
      element(:source_month_3) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth3LineAmount') }
      element(:source_month_4) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth4LineAmount') }
      element(:source_month_5) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth5LineAmount') }
      element(:source_month_6) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth6LineAmount') }
      element(:source_month_7) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth7LineAmount') }
      element(:source_month_8) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth8LineAmount') }
      element(:source_month_9) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth9LineAmount') }
      element(:source_month_10) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth10LineAmount') }
      element(:source_month_11) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth11LineAmount') }
      element(:source_month_12) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentMonth12LineAmount') }

      action(:update_source_month_1) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth1LineAmount") }
      action(:update_source_month_2) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth2LineAmount") }
      action(:update_source_month_3) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth3LineAmount") }
      action(:update_source_month_4) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth4LineAmount") }
      action(:update_source_month_5) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth5LineAmount") }
      action(:update_source_month_6) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth6LineAmount") }
      action(:update_source_month_7) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth7LineAmount") }
      action(:update_source_month_8) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth8LineAmount") }
      action(:update_source_month_9) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth9LineAmount") }
      action(:update_source_month_10) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth10LineAmount") }
      action(:update_source_month_11) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth11LineAmount") }
      action(:update_source_month_12) { |i, b| b.frm.text_field(name: "document.sourceAccountingLine[#{i}].financialDocumentMonth12LineAmount") }

      action(:add_source_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
      action(:delete_source_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteSourceLine.line#{l}.anchoraccountingSourceAnchor").click }
      action(:balance_inquiry_source_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForSourceLine.line#{l}.anchoraccountingSourceexistingLineLineAnchor#{l}").click }
      action(:refresh_source_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingSourceAnchor").click }

      #ACCOUNTING LINES TO/INCREASE
      element(:target_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }
      element(:target_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
      element(:target_sub_account_code) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
      element(:target_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
      element(:target_sub_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
      element(:target_project_code) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
      element(:target_organization_reference_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
      element(:target_current_amount) { |b| b.frm.text_field(name: 'newTargetLine.currentBudgetAdjustmentAmount') }
      element(:target_base_amount) { |b| b.frm.text_field(name: 'newTargetLine.baseBudgetAdjustmentAmount') }
      element(:target_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }
      element(:target_reference_origin_code) { |b| b.frm.text_field(name: 'newTargetLine.referenceOriginCode') }
      element(:target_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }
      element(:target_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }
      element(:target_account_expired_override) { |b| b.frm.checkbox(name: 'newTargetLine.accountExpiredOverride') }

      action(:update_target_chart_code) { |i, b| b.frm.select(name: "document.targetAccountingLine[#{i}].chartOfAccountsCode") }
      action(:update_target_account_number) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].accountNumber") }
      action(:update_target_sub_account_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].subAccountNumber") }
      action(:update_target_object_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialObjectCode") }
      action(:update_target_sub_object_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialSubObjectCode") }
      action(:update_target_project_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].projectCode") }
      action(:update_target_organization_reference_id) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].organizationReferenceId") }
      action(:update_target_current_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].currentBudgetAdjustmentAmount") }
      action(:update_target_base_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].baseBudgetAdjustmentAmount") }
      action(:update_target_line_description) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentLineDescription") }
      action(:update_target_reference_origin_code) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].referenceOriginCode") }
      action(:update_target_reference_number) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].referenceNumber") }
      action(:update_target_amount) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].amount") }
      action(:update_target_account_expired_override) { |i, b| b.frm.checkbox(name: "document.targetAccountingLine[#{i}].accountExpiredOverride") }

      element(:target_month_1) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth1LineAmount') }
      element(:target_month_2) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth2LineAmount') }
      element(:target_month_3) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth3LineAmount') }
      element(:target_month_4) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth4LineAmount') }
      element(:target_month_5) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth5LineAmount') }
      element(:target_month_6) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth6LineAmount') }
      element(:target_month_7) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth7LineAmount') }
      element(:target_month_8) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth8LineAmount') }
      element(:target_month_9) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth9LineAmount') }
      element(:target_month_10) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth10LineAmount') }
      element(:target_month_11) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth11LineAmount') }
      element(:target_month_12) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentMonth12LineAmount') }

      action(:update_target_month_1) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth1LineAmount") }
      action(:update_target_month_2) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth2LineAmount") }
      action(:update_target_month_3) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth3LineAmount") }
      action(:update_target_month_4) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth4LineAmount") }
      action(:update_target_month_5) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth5LineAmount") }
      action(:update_target_month_6) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth6LineAmount") }
      action(:update_target_month_7) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth7LineAmount") }
      action(:update_target_month_8) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth8LineAmount") }
      action(:update_target_month_9) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth9LineAmount") }
      action(:update_target_month_10) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth10LineAmount") }
      action(:update_target_month_11) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth11LineAmount") }
      action(:update_target_month_12) { |i, b| b.frm.text_field(name: "document.targetAccountingLine[#{i}].financialDocumentMonth12LineAmount") }

      action(:add_target_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }
      action(:delete_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteTargetLine.line#{l}.anchoraccountingTargetAnchor").click }
      action(:balance_inquiry_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForTargetLine.line#{l}.anchoraccountingTargetexistingLineLineAnchor#{l}").click }
      action(:refresh_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingTargetAnchor").click }

      # For Uploading Documents
      element(:account_line_source_file_name) { |b| b.frm.div(id: 'uploaddocument.sourceAccountingLinesDiv').file_field(name: 'sourceFile') }
      element(:account_line_target_file_name) { |b| b.frm.div(id: 'uploaddocument.targetAccountingLinesDiv').file_field(name: 'targetFile') }
      action(:import_lines_source) {|b| b.frm.link(id: 'document.sourceAccountingLinesShowLink').click }
      action(:import_lines_target) {|b| b.frm.link(id: 'document.targetAccountingLinesShowLink').click }
      action(:add_source_import) { |b| b.frm.button(name: 'methodToCall.uploadSourceLines.document.sourceAccountingLines').click }
      action(:add_target_import) { |b| b.frm.button(name: 'methodToCall.uploadTargetLines.document.targetAccountingLines').click }
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
      element(:notes_tab) { |b| b.div(id: 'tab-NotesandAttachments-div') }

      #viewing document where changes have been made
      element(:account_line_changed_text) { |b| b.td(class: 'datacell center', text: /^Accounting Line changed from:/) }

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
