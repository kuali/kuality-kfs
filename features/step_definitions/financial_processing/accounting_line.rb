Then /^"([^"]*)" should not be displayed in the Accounting Line section$/ do |msg|
  on(AdvanceDepositPage).errors.should_not include msg
end

Then /^the (.*) document accounting lines equal the General Ledger entries$/ do |document|
  # do a search for GL entries
  # go through each IB accounting line
  # match it with it's two entries in the gl
  doc_object = get(snake_case(document))

  visit(MainPage).general_ledger_entry
  on GeneralLedgerEntryLookupPage do |page|
    # We're assuming that Fiscal Year and Fiscal Period default to today's values
    page.doc_number.fit        doc_object.document_id
    page.balance_type_code.fit ''
    page.pending_entry_approved_indicator_all
    page.search

    # verify number of resuls is twice the number of accounting lines
    (page.results_table.rows.length-1).should == (doc_object.accounting_lines[:source].length + doc_object.accounting_lines[:target].length) * 2

    page.results_table.rows.each do |row|
    end

    all_accounting_lines = doc_object.accounting_lines[:source] + doc_object.accounting_lines[:target]
    all_accounting_lines.each do |accounting_line|
      found_original = false
      found_offset = false

      account_number_col = page.column_index(:account_number)
      amount_col = page.column_index(:transaction_ledger_entry_amount)
      description_col = page.column_index(:transaction_ledger_entry_description)

      page.results_table.rows.each do |row|
        if row[account_number_col].text == accounting_line.account_number && row[amount_col].text.groom == accounting_line.amount.groom
          if row[description_col].text.strip == accounting_line.line_description.strip
            found_original = true
          else if row[description_col].text.strip == 'TP Generated Offset'
                 found_offset = true
               end
          end
        end
      end
      found_original.should be true
      found_offset.should be true
    end
  end
end

Then /^the (.*) document accounting lines equal the General Ledger Pending entries$/ do |document|
  # view the document?
  # open up pending entries
  # match accounts with GLPEs
  doc_object = get(snake_case(document))
  page_klass = Kernel.const_get(doc_object.class.to_s.gsub(/(.*)Object$/,'\1Page'))

  on page_klass do |page|
    page.expand_all

    # verify number of resuls is twice the number of accounting lines
    (page.glpe_results_table.rows.length-1).should == (doc_object.accounting_lines[:source].length + doc_object.accounting_lines[:target].length) * 2

    all_accounting_lines = doc_object.accounting_lines[:source] + doc_object.accounting_lines[:target]
    all_accounting_lines.each do |accounting_line|
      found_d = false
      found_c = false

      account_number_col = page.glpe_results_table.keyed_column_index(:account_number)
      amount_col = page.glpe_results_table.keyed_column_index(:amount)
      dc_col = page.glpe_results_table.keyed_column_index(:d_c)

      page.glpe_results_table.rest.each do |row|
        if row[account_number_col].text == accounting_line.account_number && row[amount_col].text.groom == accounting_line.amount.to_s.groom
          if row[dc_col].text.strip == 'D'
            found_d = true
          else if row[dc_col].text.strip == 'C'
                 found_c = true
               end
          end
        end
      end
      found_d.should be true
      found_c.should be true
    end
  end
end

And /^I lookup the (Encumbrance|Disencumbrance|Source|Target|From|To) Accounting Line for the (.*) document via Available Balances with these options selected:$/ do |al_type, document, table|
  doc_object = document_object_for(document)
  alt = AccountingLineObject::get_type_conversion(al_type)

  visit(MainPage).available_balances
  on AvailableBalancesLookupPage do |lookup|
    lookup.fiscal_year.fit                  get_aft_parameter_value(ParameterConstants::CURRENT_FISCAL_YEAR)
    lookup.chart_code.fit                   doc_object.accounting_lines[alt].first.chart_code # We're assuming this exists, of course.
    lookup.account_number.fit               doc_object.accounting_lines[alt].first.account_number
    lookup.send("consolidation_option_#{snake_case(table.rows_hash['Consolidation Option']).to_s}") unless table.rows_hash['Consolidation Option'].nil?
    lookup.send("include_pending_entry_approved_indicator_#{table.rows_hash['Include Pending Ledger Entry'].downcase}") unless table.rows_hash['Include Pending Ledger Entry'].nil?
    lookup.search
  end
end

And /^these fields in the Available Balances lookup match the ones submitted in the (.*) document:$/ do |document, table|
  # Note: This assumes you're already on the Available Balances lookup page and have run the lookup
  doc_object = document_object_for(document)
  lookup_cols = table.raw.flatten.collect { |f| on(AvailableBalancesLookupPage).column_index(snake_case(f)) }

  lookup_cols.each do |col|
    case col
      when :encumbrance_amount
        on(AvailableBalancesLookupPage).column(col).any? { |cell| cell.text == doc_object.accounting_lines[:source].first.amount }
      else
        # Do nothing
    end
  end
end

And /^I open the (.*) General Ledger Balance Lookup in the Available Balances lookup that matches the one submitted for (Encumbrance|Disencumbrance|Source|Target|From|To) Accounting Line on the (.*) document$/ do |column, al_type, document|
  # Note: This assumes you're already on the Available Balances lookup page and have run the lookup
  doc_object = document_object_for(document)
  alt = AccountingLineObject::get_type_conversion(al_type)
  col = on(AvailableBalancesLookupPage).column_index(snake_case(column))

  case snake_case(column)
    when :encumbrance_amount
      on(AvailableBalancesLookupPage) do |p|
        p.item_row(doc_object.accounting_lines[alt].first.object)[col]
        .link
        .click
        p.use_new_tab
        p.close_parents
      end
    else
      # Do nothing
  end
end

And /^the (Encumbrance|Disencumbrance|Source|Target|From|To) Accounting Line on the General Ledger Balance lookup for the (.*) document equals the displayed amounts$/ do |al_type, document|
  doc_object = document_object_for(document)
  alt = AccountingLineObject::get_type_conversion(al_type)
  col = on(GeneralLedgerBalanceLookupPage).column_index(snake_case('Transaction Ledger Entry Amount'))

  on GeneralLedgerBalanceLookupPage do |p|
    p.item_row(document_object_for(document).document_id)[col].text.to_f.should == doc_object.accounting_lines[alt].first.amount.to_f
  end
end

And /^the (Encumbrance|Disencumbrance|Source|Target|From|To) Accounting Line entry matches the (.*) document's entry$/ do |al_type, document|
  doc_object = document_object_for(document)
  alt = AccountingLineObject::get_type_conversion(al_type)
  on AccountingLine do |entry_page|
    # We're going to just compare against the first submitted line
    ((entry_page.send("result_#{alt.to_s}_chart_code")).should == doc_object.accounting_lines[alt].first.chart_code) unless doc_object.accounting_lines[alt].first.chart_code.nil?
    ((entry_page.send("result_#{alt.to_s}_account_number")).should == doc_object.accounting_lines[alt].first.account_number) unless doc_object.accounting_lines[alt].first.account_number.nil?
    ((entry_page.send("result_#{alt.to_s}_sub_account_code")).should == doc_object.accounting_lines[alt].first.sub_account) unless doc_object.accounting_lines[alt].first.sub_account.nil?
    ((entry_page.send("result_#{alt.to_s}_object_code")).should == doc_object.accounting_lines[alt].first.object) unless doc_object.accounting_lines[alt].first.object.nil?
    ((entry_page.send("result_#{alt.to_s}_sub_object_code")).should == doc_object.accounting_lines[alt].first.sub_object) unless doc_object.accounting_lines[alt].first.sub_object.nil?
    ((entry_page.send("result_#{alt.to_s}_project_code")).should == doc_object.accounting_lines[alt].first.project) unless doc_object.accounting_lines[alt].first.project.nil?
    ((entry_page.send("result_#{alt.to_s}_organization_reference_id")).should == doc_object.accounting_lines[alt].first.org_ref_id) unless doc_object.accounting_lines[alt].first.org_ref_id.nil?
    ((entry_page.send("result_#{alt.to_s}_line_description")).should == doc_object.accounting_lines[alt].first.line_description) unless doc_object.accounting_lines[alt].first.line_description.nil?
    ((entry_page.send("result_#{alt.to_s}_reference_origin_code")).should == doc_object.accounting_lines[alt].first.reference_origin_code) unless doc_object.accounting_lines[alt].first.reference_origin_code.nil?
    ((entry_page.send("result_#{alt.to_s}_reference_number")).should == doc_object.accounting_lines[alt].first.reference_number) unless doc_object.accounting_lines[alt].first.reference_number.nil?
    ((entry_page.send("result_#{alt.to_s}_amount")).to_f.should == doc_object.accounting_lines[alt].first.amount.to_f) unless doc_object.accounting_lines[alt].first.amount.nil?
    ((entry_page.send("result_#{alt.to_s}_base_amount")).to_f.should == doc_object.accounting_lines[alt].first.base_amount.to_f) unless doc_object.accounting_lines[alt].first.base_amount.nil?
    ((entry_page.send("result_#{alt.to_s}_current_amount")).to_f.should == doc_object.accounting_lines[alt].first.current_amount.to_f) unless doc_object.accounting_lines[alt].first.current_amount.nil?
  end
end

And /^the General Ledger Pending entries match the accounting lines on the (.*) document$/ do |document|
  doc_object = get(snake_case(document))

  on page_class_for(document) do |page|
    page.expand_all

    num_encum_source_d = 0
    num_encum_source_c = 0
    num_disencum_target_d = 0
    num_disencum_target_c = 0

    doc_object.accounting_lines.each_value do |al_type|
      al_type.each do |accounting_line|

        account_number_col = page.glpe_results_table.keyed_column_index(:account_number)
        amount_col = page.glpe_results_table.keyed_column_index(:amount)
        dc_col = page.glpe_results_table.keyed_column_index(:d_c)

        page.glpe_results_table.rest.each do |row|
          #get the reversal date in the correct format for comparison
          reversal_date_str = row[page.glpe_results_table.keyed_column_index(:doc_reversal_date)].text.strip

          #doc reversal data is empty, pertains to the target/disencumbrance row
          if row[account_number_col].text.strip == accounting_line.account_number && row[amount_col].text.groom == accounting_line.amount.to_s.groom && reversal_date_str.length == 0
            if row[dc_col].text.strip == 'D'
              num_disencum_target_d +=1
            elsif row[dc_col].text.strip == 'C'
              num_disencum_target_c +=1
            end
            #doc reversal date has a value, pertains to the source/encumbrance line
          elsif row[account_number_col].text.strip == accounting_line.account_number && row[amount_col].text.groom == accounting_line.partial_amount.to_s.groom && reversal_date_str.length != 0
            if row[dc_col].text.strip == 'D'
              num_encum_source_d +=1
            elsif row[dc_col].text.strip == 'C'
              num_encum_source_c +=1
            end
          end
        end
      end
    end
    num_encum_source_d.should == num_encum_source_c
    num_disencum_target_d.should == num_disencum_target_c

    #number of rows in results table should equal double (sum source debits and credits)
    (page.glpe_results_table.rows.length-1).should == (num_encum_source_d + num_encum_source_c + num_disencum_target_d + num_disencum_target_c)
  end
end

And /^I add these accounting lines to the (.*) document:$/ do |document, table|
  updates = table.hashes.collect{ |h| h.snake_case_key }
  updates.each do |update|
    update[:account_number] = case update[:account_number]
                                when 'Just Created'
                                  @account.number
                                else
                                  get_account_of_type update[:account_number]
                              end
    update[:type] = AccountingLineObject::get_type_conversion(update[:type])
    document_object_for(document).add_line update[:type], update
  end
end