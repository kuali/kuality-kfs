class RequisitionPage < KFSBasePage


#REQUISITION DETAIL
  action(:chart_org_search) { |b| b.frm.table(class: 'datatable', summary: 'Detail Section').button(title: 'Search ' ).click } #there is space after search
  element(:payment_request_positive_approval_required) { |b| b.frm.checkbox(name: 'document.paymentRequestPositiveApprovalIndicator') }
  #value(:account_distribution_method) { |b| b.frm.table(class: 'datatable', summary: 'Detail Section').td(text: 'Proportional')}

  #DELIVERY
  element(:delivery_to) { |b| b.frm.text_field(name: 'document.deliveryToName') }
  element(:delivery_phone_number) { |b| b.frm.text_field(name: 'document.deliveryToPhoneNumber') }
  element(:delivery_email) { |b| b.frm.text_field(name: 'document.deliveryToEmailAddress') }
  element(:delivery_address_2) { |b| b.frm.text_field(name: 'document.deliveryBuildingLine2Address') }
  element(:delivery_date_required) { |b| b.frm.text_field(name: 'document.deliveryRequiredDate') }
  element(:delivery_room) { |b| b.frm.text_field(name: 'document.deliveryBuildingRoomNumber') }
  element(:delivery_date_required_reason) { |b| b.frm.select(name: 'document.deliveryRequiredDateReasonCode') }
  element(:delivery_instructions) { |b| b.frm.textarea(name: 'document.deliveryInstructionText') }

  action(:building_search) { |b| b.frm.button(name: /deliveryBuildingCode/).click }
  action(:room_search) { |b| b.frm.button(name: /deliveryBuildingRoomNumber/).click }

#VENDOR
  element(:vendor_name) { |b| b.frm.text_field(name: 'document.vendorName') }
  alias_method :suggested_vendor, :vendor_name
  action(:vendor_name_search) { |b| b.frm.table(class: 'datatable', summary: 'Vendor Section').button(name: /org\.kuali\.kfs\.vnd\.businessobject\.VendorDetail/).when_present.click }
  alias_method :suggested_vendor_search, :vendor_name_search

  element(:vendor_city) { |b| b.frm.text_field(name: 'document.vendorCityName') }
  element(:vendor_state) { |b| b.frm.text_field(name: 'document.vendorStateCode') }
  element(:vendor_address) { |address_field_num=1, b| b.frm.text_field(name: "document.vendorLine#{address_field_num}Address") } #1 or 2
  element(:vendor_address_1) { |b| b.frm.text_field(name: 'document.vendorLine1Address') }
  element(:vendor_address_2) { |b| b.frm.text_field(name: 'document.vendorLine2Address') }
  element(:vendor_province) { |b| b.frm.text_field(name: 'document.vendorAddressInternationalProvinceName') }

  element(:vendor_postal_code) { |b| b.frm.text_field(name: 'document.vendorPostalCode') }
  alias_method :vendor_zipcode, :vendor_postal_code

  element(:vendor_attention) { |b| b.frm.text_field(name: 'document.vendorAttentionName') }
  element(:vendor_customer_number) { |b| b.frm.text_field(name: 'document.vendorCustomerNumber') }
  element(:vendor_email) { |b| b.frm.text_field(name: 'document.vendorEmailAddress') }
  element(:vendor_notes) { |b| b.frm.textarea(name: 'document.vendorNoteText') }
  alias_method :vendor_notes_to_vendor, :vendor_notes

  element(:vendor_fax) { |b| b.frm.text_field(name: 'document.vendorFaxNumber') }
  alias_method :vendor_fax_number, :vendor_fax

  element(:vendor_name_additional) { |field_number=1, b| b.frm.text_field(name: "document.alternate#{field_number}VendorName") }
  element(:vendor_name_1) { |b| b.frm.text_field(name: 'document.alternate1VendorName') }
  element(:vendor_name_2) { |b| b.frm.text_field(name: 'document.alternate2VendorName') }
  element(:vendor_name_3) { |b| b.frm.text_field(name: 'document.alternate3VendorName') }
  element(:vendor_name_4) { |b| b.frm.text_field(name: 'document.alternate4VendorName') }
  element(:vendor_name_5) { |b| b.frm.text_field(name: 'document.alternate5VendorName') }

#VENDOR - ADD ITEM
  element(:item_type) { |b| b.frm.select(name: 'newPurchasingItemLine.itemTypeCode') }

  element(:item_quantity) { |b| b.frm.text_field(name: 'newPurchasingItemLine.itemQuantity') }
  element(:item_uom) { |b| b.frm.text_field(name: 'newPurchasingItemLine.itemUnitOfMeasureCode') }
  alias_method :item_unit_of_measure, :item_uom

  element(:item_catalog_number) { |b| b.frm.text_field(name: 'newPurchasingItemLine.itemCatalogNumber') }
  alias_method :item_catalog,:item_catalog_number

  element(:item_commodity_code) { |b| b.frm.text_field(name: 'newPurchasingItemLine.purchasingCommodityCode') }
  element(:item_description) { |b| b.frm.textarea(name: 'newPurchasingItemLine.itemDescription') }
  element(:item_unit_cost) { |b| b.frm.text_field(name: 'newPurchasingItemLine.itemUnitPrice') }
  alias_method :unit_cost, :item_unit_cost

  element(:item_restricted) { |b| b.frm.checkbox(name: 'newPurchasingItemLine.itemRestrictedIndicator') }
  element(:item_assigned_to_trade_in) { |b| b.frm.checkbox(name: 'newPurchasingItemLine.itemAssignedToTradeInIndicator') }
  alias_method :item_assigned, :item_assigned_to_trade_in

  action(:item_add) { |b| b.frm.button(title: 'Add an Item').click }

  action(:show_item_accounting_lines) { |b| b.frm.table(class: 'datatable', summary: 'Items Section').div(text: 'Accounting Lines').button(alt: 'show').click }
#ITEM ACCOUNTING LINES
  action(:item_account_number) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.accountNumber") }
  action(:item_sub_account) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.subAccountNumber") }
  action(:item_object) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.financialObjectCode") }
  alias_method :item_object_code, :item_object

  action(:item_sub_object) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.financialSubObjectCode") }
  action(:item_project) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.projectCode") }
  action(:item_org_ref_id) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.organizationReferenceId") }
  action(:item_percent) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.accountLinePercent") }
  action(:item_amount) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').text_field(name: "document.item[#{l}].newSourceLine.amount") }
  action(:item_add_account_line) { |l=0, b| b.frm.table(class: 'datatable', summary: 'Items Section').button(name: "methodToCall.insertSourceLine.line#{l}.anchoraccountingSourceAnchor").click }
  element(:balance_inquiry_button) { |b| b.frm.button(title: 'Perform Balance Inquiry for Source Accounting Line 1') }
#FREIGHT
  element(:freight_description) { |b| b.frm.textarea(name: 'document.item[0].itemDescription') }
  element(:freight_cost) { |b| b.frm.text_field(name: 'document.item[0].itemUnitPrice') }
  element(:freight_chart) { |b| b.frm.select(name: 'document.item[1].newSourceLine.chartOfAccountsCode') }
  element(:freight_account_number) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.accountNumber') }
  element(:freight_sub_account) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.subAccountNumber') }
  element(:freight_object) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.financialObjectCode') }
  element(:freight_sub_object) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.financialSubObjectCode') }
  element(:freight_project) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.projectCode') }
  element(:freight_org_ref_id) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.organizationReferenceId') }
  alias_method :freight_organization_reference_id, :freight_org_ref_id

  element(:freight_percent) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.accountLinePercent') }
  element(:freight_amount) { |b| b.frm.text_field(name: 'document.item[0].newSourceLine.amount') }
  action(:freight_add) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.line0.anchoraccountingSourceAnchor').click }

#TRADE IN
  element(:trade_in_description) { |b| b.frm.textarea(name: 'document.item[1].itemDescription') }
  element(:trade_in_cost) { |b| b.frm.text_field(name: 'document.item[1].itemUnitPrice') }

  element(:trade_in_chart) { |b| b.frm.select(name: 'document.item[1].newSourceLine.chartOfAccountsCode') }
  element(:trade_in_account_number) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.accountNumber') }

  element(:trade_in_sub_account) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.subAccountNumber') }
  element(:trade_in_object) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.financialObjectCode') }
  element(:trade_in_sub_object) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.financialSubObjectCode') }
  element(:trade_in_project) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.projectCode') }
  element(:trade_in_org_ref_id) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.organizationReferenceId') }
  alias_method :trade_in_organization_reference_id, :trade_in_org_ref_id

  element(:trade_in_percent) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.accountLinePercent') }
  element(:trade_in_amount) { |b| b.frm.text_field(name: 'document.item[1].newSourceLine.amount') }
  action(:trade_in_add) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.line1.anchoraccountingSourceAnchor').click }

#FULL ORDER DISCOUNT
  element(:full_order_description) { |b| b.frm.textarea(name: 'document.item[2].itemDescription') }
  element(:full_order_cost) { |b| b.frm.text_field(name: 'document.item[2].itemUnitPrice') }

  element(:full_order_chart) { |b| b.frm.select(name: 'document.item[2].newSourceLine.chartOfAccountsCode') }
  element(:full_order_account) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.accountNumber') }
  element(:full_order_sub_account) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.subAccountNumber') }
  element(:full_order_object) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.financialObjectCode') }
  element(:full_order_sub_object) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.financialSubObjectCode') }
  element(:full_order_project) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.projectCode') }
  element(:full_order_org_ref_id) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.organizationReferenceId') }
  element(:full_order_percent) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.accountLinePercent') }
  element(:full_order_amount) { |b| b.frm.text_field(name: 'document.item[2].newSourceLine.amount') }
  action(:full_order_add) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.line2.anchoraccountingSourceAnchor').click }

#MISCELLANEOUS
  element(:misc_description) { |b| b.frm.textarea(name: 'document.item[3].itemDescription') }
  element(:misc_cost) { |b| b.frm.text_field(name: 'document.item[3].itemUnitPrice') }
  element(:misc_account_number) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.accountNumber') }
  element(:misc_sub_account) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.subAccountNumber') }
  element(:misc_object) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.financialObjectCode') }
  element(:misc_sub_object) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.financialSubObjectCode') }
  element(:misc_project) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.projectCode') }
  element(:misc_org_ref_id) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.organizationReferenceId') }
  alias_method :misc_organization_reference_id, :misc_org_ref_id

  element(:misc_percent) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.accountLinePercent') }
  element(:misc_amount) { |b| b.frm.text_field(name: 'document.item[3].newSourceLine.amount') }

#CAPITAL ASSET
  element(:system_type) { |b| b.frm.select(name: 'document.capitalAssetSystemTypeCode') }
  element(:system_state) { |b| b.frm.select(name: 'document.capitalAssetSystemStateCode') }
  action(:select) { |b| b.frm.button(name: 'methodToCall.selectSystem').click }

  element(:asset_note) { |b| b.frm.textarea(name: 'document.purchasingCapitalAssetSystems[0].capitalAssetNoteText') }
  element(:asset_system_description) { |b| b.frm.textarea(name: 'document.purchasingCapitalAssetSystems[0].capitalAssetSystemDescription') }
#TODO different type/state selection has different manufacturer/model_number tag name
  element(:manufacturer) { |l=0, b| b.frm.text_field(name: /\[#{l}\](.[a-zA-Z]+)?.capitalAssetManufacturerName/, title: 'Manufacturer') }
  element(:model_number) { |l=0, b| b.frm.text_field(name: /\[#{l}\](.[a-zA-Z]+)?.capitalAssetModelDescription/, title: 'Model Number') }
  element(:asset_number) { |b| b.frm.text_field(name: 'document.purchasingCapitalAssetSystems[0].capitalAssetCountAssetNumber') }
  element(:transaction_type_code) { |b| b.frm.select(name: 'document.purchasingCapitalAssetItems[0].capitalAssetTransactionTypeCode') }
  action(:same_as_vendor) { |b| b.frm.button(alt: 'Manufacturer Same as Vendor').click }

#PAYMENT INFO
  element(:recurring_payment_type) { |b| b.frm.select(name: 'document.recurringPaymentTypeCode') }
  element(:payment_from_date) { |b| b.frm.text_field(name: 'document.purchaseOrderBeginDate') }
  element(:payment_to_date) { |b| b.frm.text_field(name: 'document.purchaseOrderEndDate') }

#ADDITION INFO
  element(:method_of_po_transmission) { |b| b.frm.select(name: 'document.purchaseOrderTransmissionMethodCode') }
  element(:requestor_name) { |b| b.frm.text_field(name: 'document.requestorPersonName') }
  element(:requestor_phone) { |b| b.frm.text_field(name: 'document.requestorPersonPhoneNumber') }
  element(:requestor_email) { |b| b.frm.text_field(name: 'document.requestorPersonEmailAddress') }
  element(:institution_name) { |b| b.frm.text_field(name: 'document.institutionContactName') }
  element(:institution_phone) { |b| b.frm.text_field(name: 'document.institutionContactPhoneNumber') }
  element(:institution_email) { |b| b.frm.text_field(name: 'document.institutionContactEmailAddress') }
  element(:reference_1) { |b| b.frm.text_field(name: 'document.requisitionOrganizationReference1Text') }
  element(:reference_2) { |b| b.frm.text_field(name: 'document.requisitionOrganizationReference2Text') }
  element(:reference_3) { |b| b.frm.text_field(name: 'document.requisitionOrganizationReference3Text') }
  element(:po_total_limit) { |b| b.frm.text_field(name: 'document.purchaseOrderTotalLimit') }

  # action(:calculate) { |b| b.frm.button(name: 'methodToCall.calculate').click }

  #VIEW RELATED DOCUMENTS
  action(:show_related_documents) { |b| b.frm.button(alt: 'open View Related Documents').click }
  alias_method :show_view_related_documents, :show_related_documents
  action(:show_purchase_order) { |b| b.frm.div(id: 'tab-ViewRelatedDocuments-div').button(alt: 'show').click }
  action(:close_related_documents) { |b| b.frm.button(alt: 'close View Related Documents').click }

  value(:purchase_order_number) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK').text }
  value(:po_unapprove) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').div.h3s[1].font.text }
  element(:view_related_doc) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').div.h3s }
  action(:purchase_order_number_link) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK').click; b.use_new_tab; b.close_parents }

end

