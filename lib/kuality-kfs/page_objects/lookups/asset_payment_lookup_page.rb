class AssetPaymentLookupPage < Lookups

  subaccount_facets
  financial_object_facets

  document_facets
  project_facets
  element(:tag_number) { |b| b.frm.text_field(name: 'asset.campusTagNumber') }
  element(:asset_number) { |b| b.frm.text_field(name: 'capitalAssetNumber') }
  element(:purchase_order_number) { |b| b.frm.text_field(name: 'purchaseOrderNumber') }
  element(:requisition_number) { |b| b.frm.text_field(name: 'requisitionNumber') }
  element(:document_type) { |b| b.frm.text_field(name: 'financialDocumentTypeCode') }

  element(:chart_code) { |b| b.frm.text_field(name: 'account.chartOfAccountsCode') }
  element(:organization_code) { |b| b.frm.text_field(name: 'account.organizationCode') }

  element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }

  element(:organization_reference_id) { |b| b.frm.text_field(name: 'organizationReferenceId') }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'financialDocumentPostingYear') }

  element(:fiscal_period) { |b| b.frm.select(name: 'financialDocumentPostingPeriodCode') }

  element(:posting_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_financialDocumentPostingDate') }
  element(:posting_date_to) { |b| b.frm.text_field(name: 'financialDocumentPostingDate') }
  element(:in_service_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_asset.capitalAssetInServiceDate') }
  element(:in_service_date_to) { |b| b.frm.text_field(name: 'asset.capitalAssetInServiceDate') }
  element(:amount) { |b| b.frm.text_field(name: 'accountChargeAmount') }
  element(:total_cost) { |b| b.frm.text_field(name: 'asset.totalCostAmount') }
  element(:asset_campus_code) { |b| b.frm.text_field(name: 'asset.campusCode') }
  element(:building_code) { |b| b.frm.text_field(name: 'asset.buildingCode') }
  element(:asset_status_code) { |b| b.frm.text_field(name: 'asset.inventoryStatusCode') }
  element(:asset_type_code) { |b| b.frm.text_field(name: 'asset.capitalAssetTypeCode') }

  element(:plant_chart_code) { |b| b.frm.select(name: 'account.organization.organizationPlantChartCode') }

  element(:organization_plant_account_number) { |b| b.frm.text_field(name: 'account.organization.organizationPlantAccountNumber') }

  element(:campus_plant_chart_code) { |b| b.frm.select(name: 'account.organization.campusPlantChartCode') }

  element(:campus_plant_account_number) { |b| b.frm.text_field(name: 'account.organization.campusPlantAccountNumber') }
  element(:sub_fund_group_code) { |b| b.frm.text_field(name: 'account.subFundGroupCode') }
  element(:object_sub_type_code) { |b| b.frm.text_field(name: 'financialObject.financialObjectSubTypeCode') }
  element(:asset_description) { |b| b.frm.text_field(name: 'asset.capitalAssetDescription') }

  # SEARCH RESULTS HAVE
  #edit, loan, renew, return, merge, separate, transfer, payment
end