class FinancialProcessingPage < KFSBasePage

  class << self

    def document_overview
      element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
      element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
    end

    def financial_document_detail
      value(:fdd_total_amount) { |b| b.frm.table(summary: 'KFS Detail Section').td(align: 'left').text }
    end


    #def accounting_lines
    #  element(:account_chart) { |b| b.frm.text_field(name: 'newSourceLine.chartOfAccountsCode') }
    #  element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
    #  element(:sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
    #  element(:object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
    #  element(:sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
    #  element(:project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
    #  element(:org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
    #  element(:amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
    #  element(:line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
    #
    #  action(:add_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
    #end

    def accounting_lines # formerly accounting_lines_from_to
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

      action(:update_source_chart_code) { |i=0, b| b.update_chart_code('source', i, b) }
      action(:update_source_account_number) { |i=0, b| b.update_account_number('source', i, b) }
      action(:update_source_sub_account_code) { |i=0, b| b.update_sub_account_code('source', i, b) }
      action(:update_source_object_code) { |i=0, b| b.update_object_code('source', i, b) }
      action(:update_source_sub_object_code) { |i=0, b| b.update_sub_object_code('source', i, b) }
      action(:update_source_project_code) { |i=0, b| b.update_project_code('source', i, b) }
      action(:update_source_organization_reference_id) { |i=0, b| b.update_organization_reference_id('source', i, b) }
      action(:update_source_current_amount) { |i=0, b| b.update_current_amount('source', i, b) }
      action(:update_source_base_amount) { |i=0, b| b.update_base_amount('source', i, b) }
      action(:update_source_line_description) { |i=0, b| b.update_line_description('source', i, b) }
      action(:update_source_reference_origin_code) { |i=0, b| b.update_reference_origin_code('source', i, b) }
      action(:update_source_reference_number) { |i=0, b| b.update_reference_number('source', i, b) }
      action(:update_source_amount) { |i=0, b| b.update_amount('source', i, b) }
      action(:update_source_debit) { |i=0, b| b.update_debit('source', i, b) }
      action(:update_source_credit) { |i=0, b| b.update_credit('source', i, b) }
      action(:update_source_account_expired_override) { |i=0, b| b.update_account_expired_override('source', i, b) }

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

      action(:update_source_month_1) { |i=0, b| b.update_month_1('source', i, b) }
      action(:update_source_month_2) { |i=0, b| b.update_month_2('source', i, b) }
      action(:update_source_month_3) { |i=0, b| b.update_month_3('source', i, b) }
      action(:update_source_month_4) { |i=0, b| b.update_month_4('source', i, b) }
      action(:update_source_month_5) { |i=0, b| b.update_month_5('source', i, b) }
      action(:update_source_month_6) { |i=0, b| b.update_month_6('source', i, b) }
      action(:update_source_month_7) { |i=0, b| b.update_month_7('source', i, b) }
      action(:update_source_month_8) { |i=0, b| b.update_month_8('source', i, b) }
      action(:update_source_month_9) { |i=0, b| b.update_month_9('source', i, b) }
      action(:update_source_month_10) { |i=0, b| b.update_month_10('source', i, b) }
      action(:update_source_month_11) { |i=0, b| b.update_month_11('source', i, b) }
      action(:update_source_month_12) { |i=0, b| b.update_month_12('source', i, b) }

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

      action(:update_target_chart_code) { |i=0, b| b.update_chart_code('target', i, b) }
      action(:update_target_account_number) { |i=0, b| b.update_account_number('target', i, b) }
      action(:update_target_sub_account_code) { |i=0, b| b.update_sub_account_code('target', i, b) }
      action(:update_target_object_code) { |i=0, b| b.update_object_code('target', i, b) }
      action(:update_target_sub_object_code) { |i=0, b| b.update_sub_object_code('target', i, b) }
      action(:update_target_project_code) { |i=0, b| b.update_project_code('target', i, b) }
      action(:update_target_organization_reference_id) { |i=0, b| b.update_organization_reference_id('target', i, b) }
      action(:update_target_current_amount) { |i=0, b| b.update_current_amount('target', i, b) }
      action(:update_target_base_amount) { |i=0, b| b.update_base_amount('target', i, b) }
      action(:update_target_line_description) { |i=0, b| b.update_line_description('target', i, b) }
      action(:update_target_reference_origin_code) { |i=0, b| b.update_reference_origin_code('target', i, b) }
      action(:update_target_reference_number) { |i=0, b| b.update_reference_number('target', i, b) }
      action(:update_target_amount) { |i=0, b| b.update_amount('target', i, b) }
      action(:update_target_account_expired_override) { |i=0, b| b.update_account_expired_override('target', i, b) }

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

      action(:update_target_month_1) { |i=0, b| b.update_month_1('target', i, b) }
      action(:update_target_month_2) { |i=0, b| b.update_month_2('target', i, b) }
      action(:update_target_month_3) { |i=0, b| b.update_month_3('target', i, b) }
      action(:update_target_month_4) { |i=0, b| b.update_month_4('target', i, b) }
      action(:update_target_month_5) { |i=0, b| b.update_month_5('target', i, b) }
      action(:update_target_month_6) { |i=0, b| b.update_month_6('target', i, b) }
      action(:update_target_month_7) { |i=0, b| b.update_month_7('target', i, b) }
      action(:update_target_month_8) { |i=0, b| b.update_month_8('target', i, b) }
      action(:update_target_month_9) { |i=0, b| b.update_month_9('target', i, b) }
      action(:update_target_month_10) { |i=0, b| b.update_month_10('target', i, b) }
      action(:update_target_month_11) { |i=0, b| b.update_month_11('target', i, b) }
      action(:update_target_month_12) { |i=0, b| b.update_month_12('target', i, b) }

      action(:add_target_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }
      action(:delete_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteTargetLine.line#{l}.anchoraccountingTargetAnchor").click }
      action(:balance_inquiry_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForTargetLine.line#{l}.anchoraccountingTargetexistingLineLineAnchor#{l}").click }
      action(:refresh_target_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingTargetAnchor").click }

      action(:update_chart_code) { |t='source', i=0, b| b.frm.select(name: "document.#{t}AccountingLine[#{i}].chartOfAccountsCode") }
      action(:update_account_number) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].accountNumber") }
      action(:update_sub_account_code) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].subAccountNumber") }
      action(:update_object_code) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialObjectCode") }
      action(:update_sub_object_code) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialSubObjectCode") }
      action(:update_project_code) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].projectCode") }
      action(:update_organization_reference_id) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].organizationReferenceId") }
      action(:update_current_amount) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].currentBudgetAdjustmentAmount") }
      action(:update_base_amount) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].baseBudgetAdjustmentAmount") }
      action(:update_line_description) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentLineDescription") }
      action(:update_reference_origin_code) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].referenceOriginCode") }
      action(:update_reference_number) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].referenceNumber") }
      action(:update_amount) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].amount") }
      action(:update_account_expired_override) { |t='source', i=0, b| b.frm.checkbox(name: "document.#{t}AccountingLine[#{i}].accountExpiredOverride") }

      action(:update_month_1) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth1LineAmount") }
      action(:update_month_2) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth2LineAmount") }
      action(:update_month_3) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth3LineAmount") }
      action(:update_month_4) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth4LineAmount") }
      action(:update_month_5) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth5LineAmount") }
      action(:update_month_6) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth6LineAmount") }
      action(:update_month_7) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth7LineAmount") }
      action(:update_month_8) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth8LineAmount") }
      action(:update_month_9) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth9LineAmount") }
      action(:update_month_10) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth10LineAmount") }
      action(:update_month_11) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth11LineAmount") }
      action(:update_month_12) { |t='source', i=0, b| b.frm.text_field(name: "document.#{t}AccountingLine[#{i}].financialDocumentMonth12LineAmount") }

      # For Uploading Documents
      element(:account_line_source_file_name) { |b| b.frm.div(id: 'uploaddocument.sourceAccountingLinesDiv').file_field(name: 'sourceFile') }
      element(:account_line_target_file_name) { |b| b.frm.div(id: 'uploaddocument.targetAccountingLinesDiv').file_field(name: 'targetFile') }
      action(:import_lines_source) {|b| b.frm.link(id: 'document.sourceAccountingLinesShowLink').when_present.click }
      action(:import_lines_target) {|b| b.frm.link(id: 'document.targetAccountingLinesShowLink').when_present.click }
      action(:add_source_import) { |b| b.frm.button(name: 'methodToCall.uploadSourceLines.document.sourceAccountingLines').when_present.click }
      action(:add_target_import) { |b| b.frm.button(name: 'methodToCall.uploadTargetLines.document.targetAccountingLines').when_present.click }

      # FOR VIEWING WITHOUT EDIT
      value(:source_line_description_value) {|i='0', b| b.frm.span(id: "document.sourceAccountingLine[#{i}].financialDocumentLineDescription.div").text }

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
      element(:glpe_results_table) { |b| b.frm.div(id:'tab-GeneralLedgerPendingEntries-div').table }
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
