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

      element(:credit) { |b| b.frm.text_field(name: 'newSourceLineCredit') }
      element(:debit) { |b| b.frm.text_field(name: 'newSourceLineDebit') }

      action(:chart_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].chartOfAccountsCode") }
      action(:account_number_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].accountNumber") }
      action(:sub_account_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].subAccountNumber") }
      action(:object_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialObjectCode") }
      action(:sub_object_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialSubObjectCode") }
      action(:project_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].projectCode") }
      action(:org_ref_id_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].organizationReferenceId") }
      action(:line_description_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialDocumentLineDescription") }

      action(:delete_line_item) { |line_item='0', b| b.text_field(name: "methodToCall.deleteSourceLine.line#{line_item}.anchoraccountingSourceAnchor") }
      action(:bal_inquiry_line_item) { |line_item='0', b| b.text_field(name: "methodToCall.performBalanceInquiryForSourceLine.line#{line_item}.anchoraccountingSourceexistingLineLineAnchor0") }

      action(:debit_line_item) { |line_item='0', b| b.text_field(name: "voucherLineHelper[#{line_item}].debit") }
      action(:credit_line_item) { |line_item='0', b| b.text_field(name: "voucherLineHelper[#{line_item}].credit") }

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
      element(:from_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }

      element(:from_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }

      #action(:dd_from_accounting_line) { |b| b.frm.button(title: 'Add From Accounting Line').click }

      action(:add_from_accounting_line) {|b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
      action(:add_to_accounting_line) {|b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }

      action(:add_income_accounting_line) {|b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor') }
      action(:add_expense_accounting_line) {|b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor') }

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


      #ACCOUNTING LINES TO/INCREASE
      element(:to_chart_code) { |b| b.frm.select(name: 'newTargetLine.chartOfAccountsCode') }
      element(:to_account_number) { |b| b.frm.text_field(name: 'newTargetLine.accountNumber') }
      element(:to_sub_account_code) { |b| b.frm.text_field(name: 'newTargetLine.subAccountNumber') }
      element(:to_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialObjectCode') }
      element(:to_sub_object_code) { |b| b.frm.text_field(name: 'newTargetLine.financialSubObjectCode') }
      element(:to_project_code) { |b| b.frm.text_field(name: 'newTargetLine.projectCode') }
      element(:to_organization_reference_id) { |b| b.frm.text_field(name: 'newTargetLine.organizationReferenceId') }
      element(:to_amount) { |b| b.frm.text_field(name: 'newTargetLine.amount') }

      element(:to_line_description) { |b| b.frm.text_field(name: 'newTargetLine.financialDocumentLineDescription') }

      #Budget Adjustment
      element(:from_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
      element(:from_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }
      element(:to_current_amount) { |b| b.frm.text_field(name: 'newTargetLine.currentBudgetAdjustmentAmount') }
      element(:to_base_amount) { |b| b.frm.text_field(name: 'newTargetLine.baseBudgetAdjustmentAmount') }
      action(:add_from_decrease_accounting_line) { |b| b.frm.button(title: 'Add From/Decrease Accounting Line').click }
      action(:add_to_increase_accounting_line) { |b| b.frm.button(title: 'Add To/Increase Accounting Line').click }


      #action(:add_to_accounting_line) { |b| b.frm.button(title: 'Add To Accounting Line').click }

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

      #Line Item
      action(:from_amount_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:to_amount_line_item) { |line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }

      action(:from_object_code_line_item) { |line_item, b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialObjectCode") }
      action(:from_account_number_line_item) { |b| b.text_field(name: "document.sourceAccountingLine[0].accountNumber") }
      action(:from_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:from_base_amt_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].baseBudgetAdjustmentAmount") }

      action(:to_object_code_line_item) { |line_item, b| b.text_field(name: "document.targetAccountingLine[#{line_item}].financialObjectCode") }
      action(:to_account_number_line_item) { |b| b.text_field(name: "document.targetAccountingLine[0].accountNumber") }
      action(:to_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:to_base_amt_line_item) {|line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].baseBudgetAdjustmentAmount") }

    end #accounting_lines_from_to


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
