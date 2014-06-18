class AssetManualPaymentPage < KFSBasePage

  #accounting_lines

  # ASSET ALLOCATION
  element(:asset_allocation) { |b| b.frm.select(name: 'allocationCode') }
  action(:select_asset_allocation) { |b| b.frm.button(name: 'methodToCall.selectAllocationType').click }

  # ASSETS
  element(:asset_number) { |b| b.frm.text_field(name: 'capitalAssetNumber') }
  action(:search_asset_number) { |b| b.frm.div(id: 'assets').button(name: /assetPaymentAssetDetail/).click }
  action(:add_asset_number) { |b| b.frm.div(id: 'assets').button(name: 'methodToCall.insertAssetPaymentAssetDetail').click }

  action(:allocate_amount) { |l=0, b| b.frm.div(id: 'assets').text_field(name: "document.assetPaymentAssetDetail[#{l}].allocatedUserValue") }
  action(:asset_number_update_view) { |l=0, b| b.frm.div(id: 'asstes').button(name: "methodToCall.updateAssetPaymentAssetDetail.line#{l}").click }
  action(:asset_number_delete) { |l=0, b| b.frm.div(id: 'asstes').button(name: "methodToCall.deleteAssetPaymentAssetDetail.line#{l}").click }

  # Asset Information

  # ACCOUNTING_LINE
  element(:search_po_number) { |b| b.frm.text_field(name: 'newSourceLine.purchaseOrderNumber') }
  element(:req_number) { |b| b.frm.text_field(name: 'newSourceLine.requisitionNumber') }
  element(:origin) { |b| b.frm.text_field(name: 'newSourceLine.expenditureFinancialSystemOriginationCode') }
  action(:search_origin) { |b| b.frm.button(title: 'Search Origin').click }
  element(:doc_number) { |b| b.frm.text_field(name: 'newSourceLine.expenditureFinancialDocumentNumber') }
  element(:doc_type) { |b| b.frm.text_field(name: 'newSourceLine.expenditureFinancialDocumentTypeCode') }
  element(:posted_date) { |b| b.frm.text_field(name: 'newSourceLine.expenditureFinancialDocumentPostedDate') }
  action(:show_fiscal_year) { |b| b.frm.link(title: /^show inquiry for Accounting Period University Fiscal Year=/).click }
  value(:fiscal_year_value) { |b| b.frm.link(title: /^show inquiry for Accounting Period University Fiscal Year=/).text }


  element(:chart_code) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:object) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:amount) { |b| b.frm.text_field(name: 'newSourceLine.amount') }
  element(:post_date) { |b| b.frm.text_field(name: 'newSourceLine.expenditureFinancialDocumentPostedDate') }

  action(:add_acct_line) { |b| b.frm.button(alt: 'Add Source Accounting Line').click }
  action(:update_amount) { |i=0, b| b.frm.text_field(name: "document.sourceAccountingLines[#{i}].amount") }

end