class IndirectCostRecoveryAccountsTab < KFSBasePage

  # Tab-related, mostly boilerplate stuff
  element(:icra_tab) { |b| b.frm.div(id: 'tab-IndirectCostRecoveryAccounts-div') }
  value(:current_icr_accounts_count) { |b| b.icra_tab.spans(class: 'left', text: /Indirect Cost Recovery Account [(]/m).length }
  action(:show_icr_accounts_button) { |b| b.frm.button(id: 'tab-IndirectCostRecoveryAccounts-imageToggle') }
  value(:icra_tab_shown?) { |b| b.show_icr_accounts_button.title.include?('close') }
  value(:icra_tab_hidden?) { |b| !b.icra_tab_shown? }
  action(:show_icr_accounts) { |b| b.show_icr_accounts_button.click }
  alias_method :hide_icr_accounts, :show_icr_accounts

  # Line interactions
  action(:add_icr_account) { |b| b.icra_tab.button(id: /methodToCall.addLine.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)/m).click }
  action(:delete_icr_account) { |i=0, b| b.icra_tab.button(id: /methodToCall.deleteLine.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts).(!!.line#{i}/m).click }

  # New ICR Account entry
  element(:chart_of_accounts_code) { |b| b.frm.select(name: /document.newMaintainableObject.add.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts).indirectCostRecoveryFinCoaCode/) }
  element(:account_number) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts).indirectCostRecoveryAccountNumber/) }
  element(:account_line_percent) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts).accountLinePercent/) }
  element(:active_indicator) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts).active/) }

  # Old
  value(:chart_of_accounts_code_old) { |i=0, b| b.frm.span(id: /document.oldMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].indirectCostRecoveryFinCoaCode.div/).text.strip }
  value(:account_number_old) { |i=0, b| b.frm.span(id: /document.oldMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].indirectCostRecoveryAccountNumber.div/).text.strip }
  value(:account_line_percent_old) { |i=0, b| b.frm.span(id: /document.oldMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].accountLinePercent.div/).text.strip }
  value(:active_indicator_old) { |i=0, b| yesno2setclear(b.frm.span(id: /document.oldMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].active.div/).text.strip) }

  # ICR Accounts currently in the collection
  element(:chart_of_accounts_code_update) { |i=0, b| b.icra_tab.select(name: /document.newMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].indirectCostRecoveryFinCoaCode/) }
  element(:account_number_update) { |i=0, b| b.icra_tab.text_field(name: /document.newMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].indirectCostRecoveryAccountNumber/) }
  element(:account_line_percent_update) { |i=0, b| b.icra_tab.text_field(name: /document.newMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].accountLinePercent/) }
  element(:active_indicator_update) { |i=0, b| b.icra_tab.checkbox(name: /document.newMaintainableObject.(a21SubAccount.a21IndirectCostRecoveryAccounts|indirectCostRecoveryAccounts)\[#{i}\].active/) }
  value(:chart_of_accounts_code_new) { |i=0, b| b.chart_of_accounts_code_update(i).present? ? b.chart_of_accounts_code_update(i).selected_options.first.text : b.chart_of_accounts_code_readonly(i) }
  value(:account_number_new) { |i=0, b| b.account_number_update(i).present? ? b.account_number_update(i).value : b.account_number_readonly(i) }
  value(:account_line_percent_new) { |i=0, b| b.account_line_percent_update(i).present? ? b.account_line_percent_update(i).value : b.account_line_percent_readonly(i) }
  value(:active_indicator_new) { |i=0, b| b.active_indicator_update(i).present? ? yesno2setclear(b.active_indicator_update(i).value) : b.active_indicator_readonly(i) }

  # Read-Only
  value(:chart_of_accounts_code_readonly) { |i=0, b| pending 'IndirectCostRecoveryAccountsTab::chart_of_accounts_code_readonly has not been defined yet. Please add it if you need it.' }
  value(:account_number_readonly) { |i=0, b| pending 'IndirectCostRecoveryAccountsTab::account_number_readonly has not been defined yet. Please add it if you need it.' }
  value(:account_line_percent_readonly) { |i=0, b| pending 'IndirectCostRecoveryAccountsTab::account_line_percent_readonly has not been defined yet. Please add it if you need it.' }
  value(:active_indicator_readonly) { |i=0, b| pending 'IndirectCostRecoveryAccountsTab::active_indicator_readonly has not been defined yet. Please add it if you need it.' }

end
