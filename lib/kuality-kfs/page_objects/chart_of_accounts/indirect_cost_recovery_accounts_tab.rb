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
  action(:add_icr_account) { |b| b.icra_tab.button(id: /methodToCall.addLine.indirectCostRecoveryAccounts/m).click }
  action(:delete_icr_account) { |i=0, b| b.icra_tab.button(id: "methodToCall.deleteLine.indirectCostRecoveryAccounts.(!!.line#{i}").click }

  # New ICR Account entry
  element(:chart_of_accounts_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryFinCoaCode') }
  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.indirectCostRecoveryAccountNumber') }
  element(:account_line_percent) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.accountLinePercent') }
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.indirectCostRecoveryAccounts.active') }

  # Old
  value(:old_chart_of_accounts_code) { |i=0, b| b.frm.span(id: "document.oldMaintainableObject.indirectCostRecoveryAccounts[#{i}].indirectCostRecoveryFinCoaCode.div").text.strip }
  value(:old_account_number) { |i=0, b| b.frm.span(id: "document.oldMaintainableObject.indirectCostRecoveryAccounts[#{i}].indirectCostRecoveryAccountNumber.div").text.strip }
  value(:old_account_line_percent) { |i=0, b| b.frm.span(id: "document.oldMaintainableObject.indirectCostRecoveryAccounts[#{i}].accountLinePercent.div").text.strip }
  value(:old_active_indicator) { |i=0, b| yesno2setclear(b.frm.span(id: "document.oldMaintainableObject.indirectCostRecoveryAccounts[#{i}].active.div").text.strip) }

  # New Copy
  element(:update_chart_of_accounts_code) { |i=0, b| b.icra_tab.select(name: "document.newMaintainableObject.indirectCostRecoveryAccounts[#{i}].indirectCostRecoveryFinCoaCode") }
  element(:update_account_number) { |i=0, b| b.icra_tab.text_field(name: "document.newMaintainableObject.indirectCostRecoveryAccounts[#{i}].indirectCostRecoveryAccountNumber") }
  element(:update_account_line_percent) { |i=0, b| b.icra_tab.text_field(name: "document.newMaintainableObject.indirectCostRecoveryAccounts[#{i}].accountLinePercent") }
  element(:update_active_indicator) { |i=0, b| b.icra_tab.checkbox(name: "document.newMaintainableObject.indirectCostRecoveryAccounts[#{i}].active") }
  value(:new_chart_of_accounts_code) { |i=0, b| b.update_chart_of_accounts_code(i).selected_options.first.text }
  value(:new_account_number) { |i=0, b| b.update_account_number(i).value }
  value(:new_account_line_percent) { |i=0, b| b.update_account_line_percent(i).value }
  value(:new_active_indicator) { |i=0, b| yesno2setclear(b.update_active_indicator(i).value) }

end