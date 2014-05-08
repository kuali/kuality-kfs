class DocumentSearch < Lookups

  page_url "#{$base_url}portal.do?channelTitle=Document%20Search&channelUrl=#{$base_rice_url}kew/DocumentSearch.do"

  element(:document_type) { |b| b.frm.text_field(name: 'documentTypeName') }
  element(:initiator) { |b| b.frm.text_field(name: 'initiatorPrincipalName') }
  element(:document_id_field) { |b| b.frm.text_field(name: 'documentId') }
  element(:date_created_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_dateCreated') }
  element(:date_created_to) { |b| b.frm.text_field(name: 'dateCreated') }
  element(:name_this_search_optional) { |b| b.frm.text_field(name: 'saveName') }

  element(:document_id) { |b| b.frm.text_field(id: 'documentId') }

  action(:open_doc) { |document_id, b| b.frm.link(text: document_id).click; b.use_new_tab; b.close_parents }
  action(:doc_status) { |document_id, b| b.results_table.row(text: /#{document_id}/)[3].text }

  #ADDED for REQ
  element(:application_document_status) { |b| b.frm.select(name: 'applicationDocumentStatus') }

  #element(:date_created_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_dateCreated') }
  #element(:date_created_to) { |b| b.frm.text_field(name: 'dateCreated') }
  element(:document_description) { |b| b.frm.text_field(name: 'documentAttribute.documentDescription') }
  element(:organization_document_number) { |b| b.frm.text_field(name: 'documentAttribute.organizationDocumentNumber') }
  element(:purchase_order_number) { |b| b.frm.text_field(name: 'documentAttribute.purchaseOrderIdentifier') }
  element(:requisition_number) { |b| b.frm.text_field(name: 'documentAttribute.requisitionIdentifier') }

  #selecting 'purchase_orders' the PO is different
  element(:purchase_order_numb) { |b| b.frm.text_field(name: 'documentAttribute.purapDocumentIdentifier') }

  #Selecting 'requisitions' the requisition#: html tag is different
  element(:requisition_num) { |b| b.frm.text_field(name: 'documentAttribute.purapDocumentIdentifier') }

  element(:vendor_number) { |b| b.frm.text_field(name: 'documentAttribute.vendorNumber') }
  element(:purchase_order_chart_code) { |b| b.frm.text_field(name: 'documentAttribute.documentChartOfAccountsCodeForSearching') }
  element(:purchase_order_organization_code) { |b| b.frm.text_field(name: 'documentAttribute.documentOrganizationCodeForSearching') }
  element(:requestor_name) { |b| b.frm.text_field(name: 'documentAttribute.requestorPersonName') }
  element(:assigned_to_user) { |b| b.frm.text_field(name: 'documentAttribute.assignedUserPrincipalName') }
  element(:delivery_campus) { |b| b.frm.text_field(name: 'documentAttribute.deliveryCampusCodeForSearch') }

  element(:contract_manager) { |b| b.frm.text_field(name: 'documentAttribute.contractManagerCode') }
  element(:previous_purchase_order) { |b| b.frm.text_field(name: 'documentAttribute.purchaseOrderPreviousIdentifier') }
  element(:last_transmit_from) { |b| b.frm.text_field(name: 'documentAttribute.rangeLowerBoundKeyPrefix_purchaseOrderLastTransmitTimestamp') }
  element(:last_transmit_to) { |b| b.frm.text_field(name: 'documentAttribute.purchaseOrderLastTransmitTimestamp') }
  element(:date_required_from) { |b| b.frm.text_field(name: 'documentAttribute.rangeLowerBoundKeyPrefix_deliveryRequiredDate') }
  element(:date_required_to) { |b| b.frm.text_field(name: 'documentAttribute.deliveryRequiredDate') }
  element(:date_required_reason) { |b| b.frm.select(name: 'documentAttribute.deliveryRequiredDateReasonCode') }

  element(:receiving_required_yes) { |b| b.frm.radio(id: 'documentAttribute.receivingDocumentRequiredIndicatorForSearchingYes') }
  element(:receiving_required_no) { |b| b.frm.radio(id: 'documentAttribute.receivingDocumentRequiredIndicatorForSearchingNo') }
  element(:receiving_required_both) { |b| b.frm.radio(id: 'documentAttribute.receivingDocumentRequiredIndicatorForSearchingBoth') }

  element(:payment_request_positive_approval_required_yes) { |b| b.frm.radio(id: 'documentAttribute.paymentRequestPositiveApprovalIndicatorForSearchingYes') }
  element(:payment_request_positive_approval_required_no) { |b| b.frm.radio(id: 'documentAttribute.paymentRequestPositiveApprovalIndicatorForSearchingNo') }
  element(:payment_request_positive_approval_required_both) { |b| b.frm.radio(id: 'documentAttribute.paymentRequestPositiveApprovalIndicatorForSearchingBoth') }

  element(:required_current_document_only_yes) { |b| b.frm.radio(id: 'documentAttribute.purchaseOrderCurrentIndicatorForSearchingYes') }
  element(:required_current_document_only_no) { |b| b.frm.radio(id: 'documentAttribute.purchaseOrderCurrentIndicatorForSearchingNo') }
  element(:required_current_document_only_both) { |b| b.frm.radio(id: 'documentAttribute.purchaseOrderCurrentIndicatorForSearchingBoth') }

  element(:chart_code) { |b| b.frm.select(name: 'documentAttribute.chartOfAccountsCode') }

  element(:organization_code) { |b| b.frm.text_field(name: 'documentAttribute.organizationCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'documentAttribute.accountNumber') }
  element(:ledger_document_type) { |b| b.frm.text_field(name: 'documentAttribute.financialDocumentTypeCode') }
  element(:total_amount) { |b| b.frm.text_field(name: 'documentAttribute.financialDocumentTotalAmount') }

  element(:search_result_type_document_specific_data) { |b| b.frm.radio(id: 'documentAttribute.displayTypeDocument Specific Data') }
  element(:search_result_type_workflow_data) { |b| b.frm.radio(id: 'documentAttribute.displayTypeWorkflow Data') }

  action(:detailed_search) { |b| b.frm.button(title: 'detailed search').click }
  action(:superuser_search) { |b| b.frm.button(title: 'superuser search').click }
  action(:clear_saved_searches_search) { |b| b.frm.button(title: 'clear saved searches search').click }
  action(:search_document_type) { |b| b.frm.button(title: 'Search Document Type').click }
  action(:direct_inquiry) { |b| b.frm.button(title: 'Direct Inquiry').click }
  action(:search_initiator) { |b| b.frm.button(title: 'Search Initiator').click }
  #action(:direct_inquiry) { |b| b.frm.button(title: 'Direct Inquiry').click }
  action(:search_vendor_number) { |b| b.frm.button(title: 'Search Vendor #').click }
  action(:search_purchase_order_chart_code) { |b| b.frm.button(title: 'Search Purchase Order Chart Code').click }
  action(:search_purchase_order_organization_code) { |b| b.frm.button(title: 'Search Purchase Order Organization Code').click }
  action(:search_delivery_campus) { |b| b.frm.button(title: 'Search Delivery Campus').click }
  action(:search_contract_manager) { |b| b.frm.button(title: 'Search Contract Manager').click }
  action(:search_date_required_reason) { |b| b.frm.button(title: 'Search Date Required Reason').click }
  action(:search_chart_code) { |b| b.frm.button(title: 'Search Chart Code').click }
  action(:search_organization_code) { |b| b.frm.button(title: 'Search Organization Code').click }
  action(:search_account_number) { |b| b.frm.button(title: 'Search Account Number').click }
  action(:search_ledger_document_type) { |b| b.frm.button(title: 'Search Ledger Document Type').click }

  element(:lookup_div) { |b| b.frm.div(id: 'lookup') }

  # action(:select_doc_id_with_po_number) { |purchase_number, b| b.div(id: 'tab-ViewRelatedDocuments-div').a(target: '_BLANK').click; b.use_new_tab; b.close_parents }
  # action(:select_doc_id_with_po_number) { |purchase_number, b| b.frm.table(id: 'row', class: 'datatable-100').rows.each_with_index {|row, index| (b.link(index-1).clickb.use_new_tab; b.close_parents) if row.a(text: purchase_number).exists?;  } }

end