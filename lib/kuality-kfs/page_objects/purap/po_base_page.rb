class PurchaseOrderBasePage <  KFSBasePage

  class << self

    def po_base
      element(:posting_year) { |b| b.select(name: 'document.postingYear') }
      #PURCHASSE ORDER DETAIL
      element(:payment_request_positive_approval_required) { |b| b.checkbox(name: 'document.paymentRequestPositiveApprovalIndicator') }
      alias_method :approval_required, :payment_request_positive_approval_required

      element(:previous_purchase_order_number) { |b| b.text_field(name: 'document.purchaseOrderPreviousIdentifier') }
      alias_method :previous_purchase_order, :previous_purchase_order_number

      element(:assigned_to_user) { |b| b.text_field(name: 'document.assignedUserPrincipalName') }
      element(:purchase_order_confirmed_indicator) { |b| b.checkbox(name: 'document.purchaseOrderConfirmedIndicator') }

      element(:item_assigned_to_trade_in_indicator) { |b| b.checkbox(name: 'newPurchasingItemLine.itemAssignedToTradeInIndicator') }

      #STATUS CHANGES
      element(:waiting_on_none) { |b| b.radio(title: 'Waiting on Additional Info - None') }
      element(:waiting_on_department) { |b| b.radio(title: 'Waiting on Additional Info - Department') }
      element(:waiting_on_vendor) { |b| b.radio(title: 'Waiting on Additional Info - Vendor') }

      #DELIVERY
      element(:delivery_address_2) { |b| b.text_field(name: 'document.deliveryBuildingLine2Address') }
      element(:delivery_room) { |b| b.text_field(name: 'document.deliveryBuildingRoomNumber') }

      element(:delivery_to) { |b| b.text_field(name: 'document.deliveryToName') }
      element(:delivery_phone_number) { |b| b.text_field(name: 'document.deliveryToPhoneNumber') }
      element(:delivery_email) { |b| b.text_field(name: 'document.deliveryToEmailAddress') }
      element(:delivery_date_required) { |b| b.text_field(name: 'document.deliveryRequiredDate') }
      element(:date_required_reason) { |b| b.select(name: 'document.deliveryRequiredDateReasonCode') }
      element(:delivery_instruction) { |b| b.text_field(name: 'document.deliveryInstructionText') }

      #VENDOR ADDRESS

      element(:vendor_name) { |b| b.text_field(name: 'document.vendorName') }
      alias_method :vendor, :vendor_name
      element(:vendor_address_1) { |b| b.text_field(name: 'document.vendorLine1Address') }
      element(:vendor_address_2) { |b| b.text_field(name: 'document.vendorLine2Address') }
      element(:vendor_attention) { |b| b.text_field(name: 'document.vendorAttentionName') }

      element(:vendor_city) { |b| b.text_field(name: 'document.vendorCityName') }
      element(:vendor_state) { |b| b.text_field(name: 'document.vendorStateCode') }
      element(:vendor_province) { |b| b.text_field(name: 'document.vendorAddressInternationalProvinceName') }
      element(:vendor_postal_code) { |b| b.text_field(name: 'document.vendorPostalCode') }
      alias_method :vendor_zipcode, :vendor_postal_code
      element(:vendor_country) { |b| b.select(name: 'document.vendorCountryCode') }
      action(:vendor_search) { |b| b.frm.button(name: /methodToCall.performLookup.\(!!org.kuali.kfs.vnd.businessobject.VendorDetail!!\)/m).click }

      #VENDOR INFO
      element(:vendor_choice) { |b| b.select(name: 'document.purchaseOrderVendorChoiceCode') }
      element(:vendor_customer_number) { |b| b.text_field(name: 'document.vendorCustomerNumber') }
      element(:notes_to_vendor) { |b| b.text_field(name: 'document.vendorNoteText') }
      element(:vendor_fax_number) { |b| b.text_field(name: 'document.vendorFaxNumber') }

      element(:vendor_email_address) { |b| b.text_field(name: 'document.vendorEmailAddress') }
      element(:vendor_payment_terms) { |b| b.select(name: 'document.vendorPaymentTermsCode') }
      element(:vendor_shipping_title) { |b| b.select(name: 'document.vendorShippingTitleCode') }
      element(:vendor_shipping_payment_terms) { |b| b.select(name: 'document.vendorShippingPaymentTermsCode') }

      element(:vendor_stipulation) { |b| b.text_field(name: 'newPurchaseOrderVendorStipulationLine.vendorStipulationDescription') }
      action(:vendor_add_stipulation) { |b| b.table(summary: 'Stipulations &amp; Info Section').button(name: 'methodToCall.addStipulation').click }

      #ITEMS
      element(:item_type) { |b| b.select(name: 'newPurchasingItemLine.itemTypeCode') }
      element(:item_quantity) { |b| b.text_field(name: 'newPurchasingItemLine.itemQuantity') }
      element(:item_unit_of_measure) { |b| b.text_field(name: 'newPurchasingItemLine.itemUnitOfMeasureCode') }
      alias_method :item_uom, :item_unit_of_measure

      element(:item_catalog_number) { |b| b.text_field(name: 'newPurchasingItemLine.itemCatalogNumber') }
      element(:item_commodity_code) { |b| b.text_field(name: 'newPurchasingItemLine.purchasingCommodityCode') }
      element(:item_description) { |b| b.textarea(name: 'newPurchasingItemLine.itemDescription') }
      element(:item_unit_cost) { |b| b.text_field(name: 'newPurchasingItemLine.itemUnitPrice') }
      action(:item_assigned_to_trade_in) { |l=0,b| b.checkbox(name: "document.item[#{l}].itemAssignedToTradeInIndicator") }

      action(:item_add) { |b| b.table(summary: 'Items Section').button(name: 'methodToCall.addItem').click }

      #ADDED ITEM
      action(:current_item_type) { |l=0, b| b.select(name: "document.item[#{l}].itemTypeCode") }
      action(:current_item_quantity) { |l=0, b| b.text_field(name: "document.item[#{l}].itemQuantity") }
      action(:current_item_unit_of_measure) { |l=0, b| b.text_field(name: "document.item[#{l}].itemUnitOfMeasureCode") }
      alias_method :current_item_uom, :current_item_unit_of_measure
      action(:current_item_catalog_number) { |l=0, b| b.text_field(name: "document.item[#{l}].itemCatalogNumber") }
      action(:current_item_commodity_code) { |l=0, b| b.text_field(name: "document.item[#{l}].purchasingCommodityCode") }
      action(:current_item_description) { |l=0, b| b.text_field(name: "document.item[#{l}].itemDescription") }
      action(:current_item_unit_cost) { |l=0, b| b.text_field(name: "document.item[#{l}].itemUnitPrice") }
      action(:current_item_assigned_to_trade_in) { |l=0, b| b.checkbox(name: "document.item[#{l}].itemAssignedToTradeInIndicator") }
      action(:current_item_delete) { |l=0, b| b.button(name: "methodToCall.deleteItem.line#{l}").click }

      #ACCOUNTING LINES
      element(:chart_code) { |l=0, b| b.select(name: "document.item[#{l}].newSourceLine.chartOfAccountsCode") }
      alias_method :chart, :chart_code
      element(:account_number) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.accountNumber") }
      element(:sub_account) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.subAccountNumber") }
      element(:object_code) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.financialObjectCode") }
      alias_method :object, :object_code

      element(:sub_object_code) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.financialSubObjectCode") }
      alias_method :sub_object, :sub_object_code

      element(:project) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.projectCode") }
      element(:organization_reference_id) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.organizationReferenceId") }
      alias_method :org_ref_id, :organization_reference_id

      element(:percent) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.accountLinePercent") }
      element(:amount) { |l=0, b| b.text_field(name: "document.item[#{l}].newSourceLine.amount") }
      alias_method :amt, :amount
      action(:add_account) { |l=0, b| b.button(name: "methodToCall.insertSourceLine.line#{l}.anchoraccountingSourceAnchor").click }

      #THESE ARE FOR EXISTING ACCOUNTING LINES
      action(:old_account_number) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].accountNumber") }
      action(:old_sub_account) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].subAccountNumber") }
      action(:old_object_code) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].financialObjectCode") }
      alias_method :old_object, :old_object_code
      action(:old_sub_object_code) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].financialSubObjectCode") }
      alias_method :old_sub_object, :old_sub_object_code
      action(:old_project) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].projectCode") }
      action(:old_organization_reference_id) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].organizationReferenceId") }
      alias_method :old_org_ref_id, :old_organization_reference_id
      action(:old_percent) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].accountLinePercent") }
      action(:old_amount) { |l=0, b| b.text_field(name: "document.item[#{l}].sourceAccountingLine[#{l}].amount") }
      alias_method :old_amt, :old_amount

      #PAYMENT INFO
      element(:begin_date) { |b| b.text_field(name: 'document.purchaseOrderBeginDate') }
      element(:end_date) { |b| b.text_field(name: 'document.purchaseOrderEndDate') }
      element(:recurring_payment_amount) { |b| b.text_field(name: 'document.recurringPaymentAmount') }
      element(:first_payment_date) { |b| b.text_field(name: 'document.recurringPaymentDate') }

      element(:initial_payment_amount) { |b| b.text_field(name: 'document.initialPaymentAmount') }
      element(:initial_payment_date) { |b| b.text_field(name: 'document.initialPaymentDate') }
      element(:final_payment_amount) { |b| b.text_field(name: 'document.finalPaymentAmount') }
      element(:final_payment_date) { |b| b.text_field(name: 'document.finalPaymentDate') }

      #ADDITIONAL INFO
      element(:requestor_name) { |b| b.text_field(name: 'document.requestorPersonName') }
      element(:requestor_phone_number) { |b| b.text_field(name: 'document.requestorPersonPhoneNumber') }
      alias_method :requestor_phone, :requestor_phone_number
      element(:requestor_email) { |b| b.text_field(name: 'document.requestorPersonEmailAddress') }

      element(:institution_contact_name) { |b| b.text_field(name: 'document.institutionContactName') }
      element(:institution_contact_phone_number) { |b| b.text_field(name: 'document.institutionContactPhoneNumber') }
      element(:institution_contact_email_address) { |b| b.text_field(name: 'document.institutionContactEmailAddress') }
      element(:pp_total_cannot_exceed) { |b| b.text_field(name: 'document.purchaseOrderTotalLimit') }


      #VIEW RELATED DOCUMENTS
      action(:show_related_documents) { |b| b.frm.button(alt: 'open View Related Documents').click }
      alias_method :show_view_related_documents, :show_related_documents
      action(:show_purchase_order) { |b| b.frm.div(id: 'tab-ViewRelatedDocuments-div').button(alt: 'show').click }

      value(:purchase_order_number) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK').text }
      action(:purchase_order_number_link) { |b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK').click; b.use_new_tab; b.close_parents }
      action(:open_purchase_order_number) { |po_num, b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK', text: po_num).click; b.use_new_tab; b.close_parents }

      value(:glpe_message) { |b| b.div(id: 'tab-GeneralLedgerPendingEntries-div').td.div(align: 'center').text }

      # amend PO
      action(:amend_po) { |b| b.frm.button(name: 'methodToCall.amendPo').click }
    end
  end

end