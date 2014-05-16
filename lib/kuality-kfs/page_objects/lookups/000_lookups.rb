class Lookups < BasePage

  tiny_buttons
  search_results_table

  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }
  element(:first_name) { |b| b.frm.text_field(id: 'firstName') }
  element(:full_name) { |b| b.frm.text_field(id: 'fullName') }
  element(:user_name) { |b| b.frm.text_field(id: 'userName') }
  element(:create_button) { |b| b.frm.link(title: 'Create a new record') }
  action(:create_new) { |b| b.create_button.click }
  alias_method :create, :create_new

  action(:check_item) { |name, b| b.item_row(name).checkbox(name: /selectedObjId/).set }
  action(:return_selected) { |b| b.frm.button(title: 'Return selected results').click }

  action(:edit_random) { |b| b.edit_value_links[rand(b.edit_value_links.length)].click }
  element(:edit_value_links) { |b| b.results_table.links(text: 'edit') }
  action(:copy_random) { |b| b.copy_value_links[rand(b.copy_value_links.length)].click }
  element(:copy_value_links) { |b| b.results_table.links(text: 'copy') }

  element(:lookup_title) { |b| b.frm.div(id: /headerarea/).h1.text }
  action(:on_a_lookup?) { |b| b.lookup_title.include?('Lookup') }

  action(:wait_for_search_results) do |attempts=30, b|
    while b.no_result_table_returned? && attempts > 0
      # Wait a bit and check, may be having timing issues.
      sleep 1
      attempts -= 1
      b.search
    end
    raise StandardError.new('No results returned from the lookup!') if b.no_result_table_returned?
  end

  class << self

    def document_facets
      element(:doc_number) { |b| b.frm.text_field(name: 'documentNumber') }
      alias_method :document_number, :doc_number
      element(:doc_type) { |b| b.frm.text_field(name: 'documentTypeCode') }
    end

    def account_facets
      element(:chart_code) { |b| b.frm.text_field(name: 'chartOfAccountsCode') }
      element(:account_number) { |b| b.frm.text_field(name: 'accountNumber') }
      element(:account_name) { |b| b.frm.text_field(name: 'accountName') }
      element(:account_type_code) { |b| b.frm.select(name: 'accountTypeCode') }
      element(:sub_fund_group_code) { |b| b.frm.text_field(name: 'subFundGroupCode') }
      closed_radios
    end

    def assets_facets

    end

    def subaccount_facets
      element(:sub_account_number) { |b| b.frm.text_field(name: 'subAccountNumber') }
    end

    def account_principals_facets
      element(:account_manager_principal_name) { |b| b.frm.text_field(name: 'accountManagerUser.principalName') }
      element(:account_supervisor_principal_name) { |b| b.frm.text_field(name: 'accountSupervisoryUser.principalName') }
    end

    def fiscal_officer_facets
      element(:fo_principal_name) { |b| b.frm.text_field(name: 'accountFiscalOfficerUser.principalName') }
    end

    def financial_object_facets
      element(:object_code) { |b| b.frm.text_field(name: 'financialObjectCode') }
      element(:subobject_code) { |b| b.frm.text_field(name: 'financialSubObjectCode') }
      element(:object_type_code) { |b| b.frm.text_field(name: 'financialObjectTypeCode') }
      element(:balance_type_code) { |b| b.frm.text_field(name: 'financialBalanceTypeCode') }
      element(:origin_code) { |b| b.frm.text_field(name: 'financialSystemOriginationCode') }
    end

    def selection_actions
      action(:select_all_from_this_page) { |b| b.frm.img(title: 'Select all rows from this page').when_present.click }
      action(:select_all_from_all_pages) { |b| b.frm.img(title: 'Select all rows from all pages').click }
      action(:deselect_all_from_all_pages) { |b| b.frm.img(title: 'Unselect all rows from all pages').click }
      action(:deselect_all_from_this_page) { |b| b.frm.img(title: 'Deselect all rows from this page').click }
    end

    def fiscal_year_facets
      element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
      element(:fiscal_period) { |b| b.frm.text_field(name: 'universityFiscalPeriodCode') }
    end

    def encumbrance_object_facets
      element(:encumbrance_object_code) { |b| b.frm.text_field(name: 'objectCode') }
      element(:encumbrance_subobject_code) { |b| b.frm.text_field(name: 'subObjectCode') }
      element(:encumbrance_balance_type) { |b| b.frm.text_field(name: 'balanceTypeCode') }
      element(:encumbrance_origin_code) { |b| b.frm.text_field(name: 'originCode') }
      element(:include_pending_ledger_entry) { |b| b.frm.radio(name: 'dummyBusinessObject.pendingEntryOption') }
      element(:include_zeroed_out_encumbrances) { |b| b.frm.radio(name: 'dummyBusinessObject.zeroEncumbranceOption') }
    end

    def closed_radios
      element(:closed) { |b| b.frm.radios(name: 'closed') }
      element(:closed_yes) { |b| b.frm.radio(id: 'closedYes') }
      element(:closed_no) { |b| b.frm.radio(id: 'closedNo') }
      element(:closed_both) { |b| b.frm.radio(id: 'closedBoth') }
    end

    def active_radios
      element(:active) { |b| b.frm.radios(name: 'active') }
      element(:active_yes) { |b| b.frm.radio(id: 'activeYes') }
      element(:active_no) { |b| b.frm.radio(id: 'activeNo') }
      element(:active_both) { |b| b.frm.radio(id: 'activeBoth') }
      element(:active_indicator) { |b| b.frm.radios(name: 'activeIndicator') }
      element(:active_indicator_yes) { |b| b.frm.radio(id: 'activeIndicatorYes') }
      element(:active_indicator_no) { |b| b.frm.radio(id: 'activeIndicatorNo') }
      element(:active_indicator_both) { |b| b.frm.radio(id: 'activeIndicatorBoth') }
    end

    def submit_to_cams_radios
      element(:submit_to_cams_yes) { |b| b.frm.radio(id: 'activityStatusCodeYes') }
      element(:submit_to_cams_no) { |b| b.frm.radio(id: 'activityStatusCodeNo') }
      element(:submit_to_cams_both) { |b| b.frm.radio(id: 'activityStatusCodeBoth') }
    end

    def reference_document_facets
      element(:reference_document_number) { |b| b.frm.text_field(name: 'referenceFinancialDocumentNumber') }
      element(:reference_document_type_code) { |b| b.frm.text_field(name: 'referenceFinancialDocumentTypeCode') }
      element(:reference_origin_code) { |b| b.frm.text_field(name: 'referenceFinancialSystemOriginationCode') }
    end

    def project_facets
      element(:project_code) { |b| b.frm.text_field(name: 'projectCode') }
    end

    def vendor_address_facets
      element(:address_type) { |b| b.frm.select(id: 'vendorAddressTypeCode') }
      element(:address_1) { |b| b.frm.text_field(id: 'vendorLine1Address') }
      element(:address_2) { |b| b.frm.text_field(id: 'vendorLine2Address') }
      element(:city) { |b| b.frm.text_field(id: 'vendorCityName') }
      element(:state) { |b| b.frm.text_field(id: 'vendorStateCode') }
      element(:postal_code) { |b| b.frm.text_field(id: 'vendorZipCode') }
      element(:province) { |b| b.frm.text_field(id: 'vendorAddressInternationalProvinceName') }
      element(:country) { |b| b.frm.select(id: 'vendorCountryCode') }
      element(:attention) { |b| b.frm.text_field(id: 'vendorAttentionName') }
      element(:url) { |b| b.frm.text_field(id: 'vendorBusinessToBusinessUrlAddress') }
      element(:vendor_fax_number) { |b| b.frm.text_field(id: 'vendorFaxNumber') }
      element(:email_address) { |b| b.frm.text_field(id: 'vendorAddressEmailAddress') }
    end

    def vendor_facets
      element(:vendor_name) { |b| b.frm.text_field(id: 'vendorName') }
      element(:tax_number) { |b| b.frm.text_field(id: 'vendorTaxNumber') }
      element(:vendor_number) { |b| b.frm.text_field(id: 'vendorNumber') }
      element(:vendor_type_code) { |b| b.frm.select(id: 'vendorHeader.vendorTypeCode') }
      element(:state) { |b| b.frm.text_field(id: 'vendorAddresses.StateCode') }
      element(:commodity_code) { |b| b.frm.text_field(id: 'vendorCommodities.purchasingCommodityCode') }
      element(:supplier_diversity_code) { |b| b.frm.text_field(id: 'vendorHeader.vendorSupplierDiversities.vendorSupplierDiversityCode') }
      element(:contract_number) { |b| b.frm.select(id: 'vendorContracts.vendorContractGeneratedIdentifier') }
      element(:einvoice_ind) { |b| b.frm.radios(name: 'extension.einvoiceVendorIndicator') }
      element(:einvoice_in_yes) { |b| b.frm.radio(id: 'extension.einvoiceVendorIndicatorYes') }
      element(:einvoice_in_no) { |b| b.frm.radio(id: 'extension.einvoiceVendorIndicatorNo') }
      element(:einvoice_in_both) { |b| b.frm.radio(id: 'extension.einvoiceVendorIndicatorBoth') }
    end

    def include_pending_ledger_entry_radios
      element(:include_pending_entry_approved_indicator) { |b| b.frm.radios(name: 'dummyBusinessObject.pendingEntryOption') }
      action(:include_pending_entry_approved_indicator_all) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll').set }
      action(:include_pending_entry_approved_indicator_no) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionNo').set }
      action(:include_pending_entry_approved_indicator_approved) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionApproved').set }
    end

    def consolidation_option_radios
      element(:consolidation_option) { |b| b.frm.radios(name: 'dummyBusinessObject.consolidationOption') }
      action(:consolidation_option_consolidation) { |b| b.frm.radio(id: 'dummyBusinessObject.consolidationOptionConsolidation').set }
      action(:consolidation_option_detail) { |b| b.frm.radio(id: 'dummyBusinessObject.consolidationOptionDetail').set }
      action(:consolidation_option_exclude_sub_accounts) { |b| b.frm.radio(id: 'dummyBusinessObject.pendingEntryOptionAll').set }
    end

  end

end