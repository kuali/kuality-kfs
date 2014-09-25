class AwardPage < ContractAndGrantBasePage

  cg_base
  #Award MAINTENANCE - OLD NEW
  element(:proposal_number) { |b| b.frm.span(id: 'document.newMaintainableObject.proposalNumber.div').text.strip }
  element(:status) { |b| b.frm.select(name: 'document.newMaintainableObject.awardStatusCode') }
  element(:project_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardProjectTitle') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardBeginningDate') }
  element(:stop_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardEndingDate') }
  element(:direct_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardDirectCostAmount') }
  element(:indirect_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardIndirectCostAmount') }
  element(:entry_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardEntryDate') }
  element(:purpose_code) { |b| b.frm.select(name: 'document.newMaintainableObject.awardPurposeCode') }
  element(:grant_description) { |b| b.frm.select(name: 'document.newMaintainableObject.grantDescriptionCode') }
  action(:proposal_search) { |b| b.frm.button(name: /methodToCall.performLookup.\(!!org.kuali.kfs.module.cg.businessobject.Proposal!!\)/m).click }
  element(:old_status) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardStatusCode.div').text.strip }
  element(:old_project_title) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardProjectTitle.div').text.strip }
  element(:old_start_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardBeginningDate.div').text.strip }
  element(:old_stop_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardEndingDate.div').text.strip }
  element(:old_direct_cost_amount) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardDirectCostAmount.div').text.strip }
  element(:old_indirect_cost_amount) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardIndirectCostAmount.div').text.strip }
  element(:old_entry_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardEntryDate.div').text.strip }
  element(:old_purpose_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.awardPurposeCode.div').text.strip }
  element(:old_grant_description) { |b| b.frm.span(id: 'document.oldMaintainableObject.grantDescriptionCode.div').text.strip }
  #Accounts
  element(:new_account_chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.awardAccounts.chartOfAccountsCode') }
  element(:new_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardAccounts.accountNumber') }
  element(:new_account_project_director_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardAccounts.projectDirector.principalName') }
  element(:new_account_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardAccounts.active') }
  action(:add_new_account) { |b| b.frm.button(id: /^methodToCall\.addLine\.awardAccounts/).click }
  action(:delete_account) { |i=0, b| b.frm.button(id: "methodToCall.deleteLine.awardAccounts.(!!.line#{i}").click }
  element(:account_tab) { |b| b.frm.div(id: 'tab-Accounts-div') }
  value(:current_account_count) { |b| b.account_tab.spans(class: 'left', text: /Account [(]/m).length }
  action(:update_account_chart_code) { |i=0, b|
    b.account_tab.span(id: "document.newMaintainableObject.awardAccounts[#{i}].chartOfAccountsCode.div")
  }
  action(:update_account_number) { |i=0, b|
    b.account_tab.span(id: "document.newMaintainableObject.awardAccounts[#{i}].accountNumber.div")
  }
  action(:update_account_project_director_principal_name) { |l=0, b| b.account_tab.text_field(name: "document.newMaintainableObject.awardAccounts[#{l}].projectDirector.principalName") }
  action(:update_account_active_indicator) { |l=0, b| b.account_tab.checkbox(name: "document.newMaintainableObject.awardAccounts[#{l}].active") }
  action(:old_account_chart_code) { |i=0, b| b.account_tab.span(id: "document.oldMaintainableObject.awardAccounts[#{i}].chartOfAccountsCode.div").text.strip }
  action(:old_account_number) { |i=0, b| b.account_tab.span(id: "document.oldMaintainableObject.awardAccounts[#{i}].accountNumber.div").text.strip }
  action(:old_account_project_director_principal_name) { |i=0, b| b.account_tab.span(id: "document.oldMaintainableObject.awardAccounts[#{i}].projectDirector.principalName.div").text.strip }
  action(:old_account_active_indicator) { |i=0, b| b.account_tab.span(id: "document.oldMaintainableObject.awardAccounts[#{i}].active.div").text.strip }
end
