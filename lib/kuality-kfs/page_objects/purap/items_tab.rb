class ItemsTab < PageFactory

  include Utilities
  include GlobalConfig

  element(:items_tab) { |b| b.frm.div(id: /tab-.*Items-div/m) }
  element(:items_table) { |b| b.items_tab.table(summary: 'Items Section') }
  value(:current_items_count) { |b| b.items_tab.tds(css: 'td.infoline[nowrap="nowrap"][rowspan="2"], td.infoline[nowrap="nowrap"][rowspan="3"]').to_a.length }
  action(:show_items_button) { |b| b.frm.button(id: 'tab-Items-imageToggle') }
  value(:items_tab_shown?) { |b| b.show_items_button.title.match(/close Items/m) }
  value(:items_tab_hidden?) { |b| !b.items_tab_shown? }
  action(:show_items) { |b| b.show_items_button.click }
  alias_method :hide_items, :show_items

  action(:import_item_lines) { |b| b.items_tab.button(title: 'import items from file').click }
  element(:item_line_file_name) { |b| b.items_tab.text_field(name: 'itemImportFile') }
  action(:add_item_import) { |b| b.items_tab.button(title: 'add imported items').click }
  action(:cancel_item_import) { |b| b.items_tab.button(title: 'cancel items').click }

  action(:add_item) { |b| b.items_tab.button(title: 'Add an Item').click }
  action(:delete_item) { |l=0, b| b.items_tab.button(name: "methodToCall.deleteItem.line#{l}").click }
  action(:calculate_item) { | i=0, b| b.frm.button(name: /methodToCall.recalculateItemAccountsAmounts.line#{i}./).click }

  element(:show_item_accounting_lines_button) { |l=0, b| b.items_tab.div(text: 'Accounting Lines').button(id: "tab-AccountingLines#{5+(l*2)}-imageToggle") }
  element(:item_accounting_lines_section) { |l=0, b| b.show_item_accounting_lines_button(l).parent }
  value(:item_accounting_lines_shown?) { |l=0, b| b.show_item_accounting_lines_button(l).alt.match('hide') }
  value(:item_accounting_lines_hidden?) { |l=0, b| !b.item_accounting_lines_shown?(l) }
  action(:show_item_accounting_lines) { |l=0, b| b.show_item_accounting_lines_button(l).click }
  alias_method :hide_item_accounting_lines, :show_item_accounting_lines


  element(:type) { |b| b.items_tab.select(name: 'newPurchasingItemLine.itemTypeCode') }
  element(:quantity) { |b| b.items_tab.text_field(name: 'newPurchasingItemLine.itemQuantity') }
  element(:uom) { |b| b.items_tab.text_field(name: 'newPurchasingItemLine.itemUnitOfMeasureCode') }
  alias_method :unit_of_measure, :uom
  element(:catalog_number) { |b| b.items_tab.text_field(name: 'newPurchasingItemLine.itemCatalogNumber') }
  element(:commodity_code) { |b| b.items_tab.text_field(name: 'newPurchasingItemLine.purchasingCommodityCode') }
  element(:description) { |b| b.items_tab.textarea(name: 'newPurchasingItemLine.itemDescription') }
  element(:unit_cost) { |b| b.items_tab.text_field(name: 'newPurchasingItemLine.itemUnitPrice') }
  element(:extended_cost) { |b| b.items_tab.button(title: 'Add an Item').parent.tds[8].text } # This value is read-only. It'd be nice to be able to get at it without giving the index.
  element(:restricted) { |b| b.items_tab.checkbox(name: 'newPurchasingItemLine.itemRestrictedIndicator') }
  element(:assigned_to_trade_in) { |b| b.items_tab.checkbox(name: 'newPurchasingItemLine.itemAssignedToTradeInIndicator') }

  element(:update_type) { |l=0, b| b.items_tab.select(id: "document.item[#{l}].itemTypeCode") }
  element(:update_quantity) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].itemQuantity") }
  element(:update_uom) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].itemUnitOfMeasureCode") }
  element(:update_catalog_number) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].itemCatalogNumber") }
  element(:update_commodity_code) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].purchasingCommodityCode") }
  element(:update_description) { |l=0, b| b.items_tab.textarea(id: "document.item[#{l}].itemDescription") }
  element(:update_unit_cost) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].itemUnitPrice") }
  element(:update_extended_cost) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].extendedPrice").exists? ? b.items_tab.text_field(id: "document.item[#{l}].extendedPrice") : b.items_table[result_line_index_for(l, b)][item_col_for(b, :uom)].parent.parent.tds[8] } # This value is read-only. It'd be nice to be able to get at it without giving the index.
  element(:update_extended_price) { |l=0, b| b.items_tab.text_field(id: "document.item[#{l}].itemUnitPrice") }
  element(:update_restricted) { |l=0, b| b.items_tab.checkbox(id: "document.item[#{l}].itemRestrictedIndicator") }
  element(:update_assigned_to_trade_in) { |l=0, b| b.items_tab.checkbox(id: "document.item[#{l}].itemAssignedToTradeInIndicator") }

  # TODO: Finish the read-only section when we are ready to write an #absorb! method
  class << self
    def result_line_index_for(l, b)
      # 3 Header lines, then
      # For every item:
      # 1 subheader line
      # 3 data lines, where the last two contain the Accounting Lines (1 header, 1 data)
      header_lines = on_process_items?(b) ? 7 : 4
      row_lines = on_process_items?(b) ? 3 : 2
      header_lines+(l*row_lines)
    end

    def item_col_for(b, k)
      opi = on_process_items?(b)
      hl = opi ? 6 : 2 # Where's the header line?
      case k
        when :type
          b.items_table.keyed_column_index(:item_type, hl)
        when :quantity
          b.items_table.keyed_column_index((opi ? :open_qty : :quantity), hl)
        when :uom
          b.items_table.keyed_column_index(:uom, hl)
        when :catalog_number
          b.items_table.keyed_column_index(:catalog, hl)
        when :commodity_code
          b.items_table.keyed_column_index(:commodity_code, hl)
        when :description
          b.items_table.keyed_column_index(:description, hl)
        when :unit_cost
          b.items_table.keyed_column_index(:unit_cost, hl)
        when :po_unit_ext_price
          b.items_table.keyed_column_index(:po_unit_ext_price, hl)
        when :extended_cost
          b.items_table.keyed_column_index(:extended_cost, hl)
        when :restricted
          b.items_table.keyed_column_index(:restricted, hl)
        when :assigned_to_trade_in
          b.items_table.keyed_column_index(:assigned_to_trade_in, hl)
      end
    end

    def on_process_items?(b)
      b.frm.div(id: /tab-ProcessItems-div/m).present?
    end
  end

  value(:result_type) { |l=0, b|
    !on_process_items?(b) && !item_col_for(b, :type).nil? &&
    b.items_table[result_line_index_for(l, b)][1].present? ? b.items_table[result_line_index_for(l, b)][1].text.strip : ""
  }
  value(:result_quantity) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :quantity)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :quantity)].text.strip : "" }
  value(:result_uom) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :uom)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :uom)].text.split(/\n/)[-1].strip : "" }
  value(:result_catalog_number) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :catalog_number)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :catalog_number)].text.strip : "" }
  value(:result_commodity_code) { |l=0, b|
    !on_process_items?(b) && !item_col_for(b, :commodity_code).nil? &&
    b.items_table[result_line_index_for(l, b)][item_col_for(b, :commodity_code)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :commodity_code)].text.strip.split(/\n/)[0] : nil
  }
  value(:result_description) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :description)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :description)].text.strip : "" }
  value(:result_unit_cost) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :unit_cost)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :unit_cost)].text.strip : "" }
  value(:result_po_unit_ext_price) { |l=0, b|
    on_process_items?(b) && !item_col_for(b, :po_unit_ext_price).nil? &&
    b.items_table[result_line_index_for(l, b)][item_col_for(b, :po_unit_ext_price)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :po_unit_ext_price)].text.strip : nil
  }
  value(:result_extended_cost) { |l=0, b| b.items_table[result_line_index_for(l, b)][item_col_for(b, :extended_cost)].present? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :extended_cost)].text.strip : "" }
  value(:result_restricted) { |l=0, b|
    !on_process_items?(b) && !item_col_for(b, :restricted).nil? &&
    b.items_table[result_line_index_for(l, b)][item_col_for(b, :restricted)].exists? ? b.items_table[result_line_index_for(l, b)][item_col_for(b, :restricted)].text.strip : nil
  }
  value(:result_assigned_to_trade_in) { |l=0, b|
    !on_process_items?(b) && !item_col_for(b, :restricted).nil? &&
    b.items_table[result_line_index_for(l, b)][item_col_for(b, :assigned_to_trade_in)].text.strip
  }

  #ITEM ACCOUNTING LINES
  action(:add_item_accounting_line) { |i=0, b| b.frm.button(name: "methodToCall.insertSourceLine.line#{i}.anchoraccountingSourceAnchor").click }
  action(:delete_item_accounting_line) { |i=0, l=0, b| b.frm.button(name: "methodToCall.deleteSourceLine.line#{i}:#{l}.anchoraccountingSourceAnchor").click }
  action(:balance_inquiry_item_accounting_line) { |i=0, l=0, b|
    b.frm.button(name: "methodToCall.performBalanceInquiryForSourceLine.line:#{i}:#{l}.anchoraccountingSourceexistingLineLineAnchor#{l}").click
  }
  value(:current_accounting_line_count) { |i=0, b|
    r = "document.item\\[#{i}\\].sourceAccountingLine\\[\\d+\\].chartOfAccountsCode"
    b.items_table.select(name: /#{r}/).present? ? b.frm.selects(name: /#{r}/m).length : b.readonly_current_accounting_line_count(i, b)
  }
  value(:readonly_current_accounting_line_count) { |i=0, b|
    r = "document.item\\[#{i}\\].sourceAccountingLine\\[\\d+\\].chartOfAccountsCode.div"
    b.items_table.spans(id: /#{r}/).length
  }

  element(:chart_code) { |i=0, b| b.frm.select(name: "document.item[#{i}].newSourceLine.chartOfAccountsCode") }
  element(:account_number) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.accountNumber") }
  element(:sub_account_code) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.subAccountNumber") }
  element(:object_code) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.financialObjectCode") }
  element(:sub_object_code) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.financialSubObjectCode") }
  element(:project_code) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.projectCode") }
  element(:organization_reference_id) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.organizationReferenceId") }
  element(:line_description) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.financialDocumentLineDescription") }
  element(:percent) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.accountLinePercent") }
  element(:amount) { |i=0, b| b.frm.text_field(name: "document.item[#{i}].newSourceLine.amount") }

  element(:update_chart_code) { |i=0, l=0, b| b.frm.select(name: "document.item[#{i}].sourceAccountingLine[#{l}].chartOfAccountsCode") }
  element(:update_account_number) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].accountNumber") }
  element(:update_sub_account_code) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].subAccountNumber") }
  element(:update_object_code) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].financialObjectCode") }
  element(:update_sub_object_code) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].financialSubObjectCode") }
  element(:update_project_code) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].projectCode") }
  element(:update_organization_reference_id) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].organizationReferenceId") }
  element(:update_line_description) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].financialDocumentLineDescription") }
  element(:update_percent) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].accountLinePercent") }
  element(:update_amount) { |i=0, l=0, b| b.frm.text_field(name: "document.item[#{i}].sourceAccountingLine[#{l}].amount") }

  element(:result_chart_code) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].chartOfAccountsCode.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].chartOfAccountsCode.div").text.strip : nil }
  element(:result_account_number) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].accountNumber.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].accountNumber.div").text.strip : nil }
  element(:result_sub_account_code) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].subAccountNumber.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].subAccountNumber.div").text.strip : nil}
  element(:result_object_code) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialObjectCode.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialObjectCode.div").text.strip : nil }
  element(:result_sub_object_code) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialSubObjectCode.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialSubObjectCode.div").text.strip : nil }
  element(:result_project_code) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].projectCode.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].projectCode.div").text.strip : nil }
  element(:result_organization_reference_id) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].organizationReferenceId.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].organizationReferenceId.div").text.strip : nil }
  element(:result_line_description) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialDocumentLineDescription.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].financialDocumentLineDescription.div").text.strip : nil }
  element(:result_percent) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].accountLinePercent.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].accountLinePercent.div").text.strip : nil }
  element(:result_amount) { |i=0, l=0, b| b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].amount.div").present? ? b.frm.span(id: "document.item[#{i}].sourceAccountingLine[#{l}].amount.div").text.strip : nil }

  element(:balance_inquiry_button) { |b| b.frm.button(title: 'Perform Balance Inquiry for Source Accounting Line 1') }

end

