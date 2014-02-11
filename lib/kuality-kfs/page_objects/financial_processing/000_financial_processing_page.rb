class FinancialProcessingPage < KFSBasePage


  class << self

    def document_overview
      element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
      element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
    end

    def financial_document_detail
      value(:fdd_total_amount) { |b| b.frm.table(summary: 'KFS Detail Section').td(align: 'left').text }
      element(:bank_code_field) {|b| b.frm.text_field(name: 'document.financialDocumentBankCode') }
    end

    def accounting_lines_from_to
      #ACCOUNTING LINES FROM/DECREASE
      element(:from_chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
      alias_method :account_chart, :from_chart_code

      element(:from_account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
      alias_method :account_number, :from_account_number
      element(:from_sub_account_code) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
      alias_method :sub_account_number, :from_sub_account_code
      element(:from_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
      alias_method :object_code, :from_object_code
      element(:from_sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
      alias_method :sub_object_code, :from_sub_object_code
      element(:from_project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
      alias_method :project_code, :from_project_code
      element(:from_organization_reference_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
      alias_method :org_ref_id, :from_organization_reference_id
      element(:from_amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
      alias_method :amount, :from_amount
      element(:from_line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }
      alias_method :line_description, :from_line_description

      element(:from_current_amount) { |b| b.frm.text_field(name: 'newSourceLine.currentBudgetAdjustmentAmount') }
      element(:from_base_amount) { |b| b.frm.text_field(name: 'newSourceLine.baseBudgetAdjustmentAmount') }

      element(:from_reference_origin_code) { |b| b.frm.text_field(name: 'newSourceLine.referenceOriginCode') }
      alias_method :reference_origin_code, :from_reference_origin_code
      element(:from_reference_number) { |b| b.frm.text_field(name: 'newSourceLine.referenceNumber') }
      alias_method :reference_number, :from_reference_number

      element(:from_account_expired_override) { |b| b.frm.checkbox(name: 'newSourceLine.accountExpiredOverride') }

      #action(:dd_from_accounting_line) { |b| b.frm.button(title: 'Add From Accounting Line').click }

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

      action(:add_from_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
      alias_method :add_accounting_line, :add_from_accounting_line

      action(:delete_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteSourceLine.line#{l}.anchoraccountingSourceAnchor").click }
      alias_method :delete_line_item, :delete_from_accounting_line

      action(:balance_inquiry_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForSourceLine.line#{l}.anchoraccountingSourceexistingLineLineAnchor#{l}").click }
      alias_method :bal_inquiry_line_item, :balance_inquiry_from_accounting_line
      action(:refresh_from_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingSourceAnchor").click }

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
      element(:to_current_amount) { |b| b.frm.text_field(name: 'newTargetLine.currentBudgetAdjustmentAmount') }
      element(:to_base_amount) { |b| b.frm.text_field(name: 'newTargetLine.baseBudgetAdjustmentAmount') }

      element(:to_reference_origin_code) { |b| b.frm.text_field(name: 'newTargetLine.referenceOriginCode') }
      element(:to_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }
      
      element(:to_account_expired_override) { |b| b.frm.checkbox(name: 'newTargetLine.accountExpiredOverride') }
      action(:add_from_decrease_accounting_line) { |b| b.frm.button(title: 'Add From/Decrease Accounting Line').click }
      action(:add_to_increase_accounting_line) { |b| b.frm.button(title: 'Add To/Increase Accounting Line').click }

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

      action(:add_to_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertTargetLine.anchoraccountingTargetAnchor').click }
      action(:delete_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.deleteTargetLine.line#{l}.anchoraccountingTargetAnchor").click }
      action(:balance_inquiry_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.performBalanceInquiryForTargetLine.line#{l}.anchoraccountingTargetexistingLineLineAnchor#{l}").click }
      action(:refresh_to_accounting_line) { |l=0, b| b.frm.button(name: "methodToCall.refresh.line#{l}.anchoraccountingTargetAnchor").click }

      action(:from_amount_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:to_amount_line_item) { |line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }

      action(:from_object_code_line_item) { |line_item, b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialObjectCode") }
      alias_method :object_code_line_item, :from_object_code_line_item
      action(:from_account_number_line_item) { |l, b| b.text_field(name: "document.sourceAccountingLine[#{l}].accountNumber") }
      alias_method :account_number_line_item, :from_account_number_line_item
      action(:from_sub_account_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].subAccountNumber") }
      alias_method :sub_account_code_line_item, :from_sub_account_code_line_item

      action(:from_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:from_base_amt_line_item) {|line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].baseBudgetAdjustmentAmount") }

      action(:to_object_code_line_item) { |line_item, b| b.text_field(name: "document.targetAccountingLine[#{line_item}].financialObjectCode") }
      action(:to_account_number_line_item) { |b| b.text_field(name: "document.targetAccountingLine[0].accountNumber") }

      action(:to_current_amount_line_item) {|line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].currentBudgetAdjustmentAmount") }
      action(:to_base_amt_line_item) {|line_item='0', b| b.text_field(name: "document.targetAccountingLine[#{line_item}].baseBudgetAdjustmentAmount") }

      action(:debit_line_item) { |line_item='0', b| b.text_field(name: "voucherLineHelper[#{line_item}].debit") }
      action(:credit_line_item) { |line_item='0', b| b.text_field(name: "voucherLineHelper[#{line_item}].credit") }

      element(:credit) { |b| b.frm.text_field(name: 'newSourceLineCredit') }
      alias_method :credit_amount, :credit
      element(:debit) { |b| b.frm.text_field(name: 'newSourceLineDebit') }
      alias_method :debit_amount, :debit

      action(:from_sub_object_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialSubObjectCode") }
      alias_method :sub_object_code_line_item, :from_sub_object_code_line_item
      action(:from_project_code_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].projectCode") }
      alias_method :project_code_line_item, :from_project_code_line_item
      action(:from_org_ref_id_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].organizationReferenceId") }
      alias_method :org_ref_id_line_item, :from_org_ref_id_line_item
      action(:line_description_line_item) { |line_item='0', b| b.text_field(name: "document.sourceAccountingLine[#{line_item}].financialDocumentLineDescription") }
      alias_method :line_description_line_item, :from_line_description_line_item

    end #accounting_lines_from_to
    alias_method :accounting_lines, :accounting_lines_from_to

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
