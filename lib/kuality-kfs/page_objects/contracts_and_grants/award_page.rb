class AwardPage < ContractAndGrantPage

  organization_lines
  project_director_lines
  subcontractor_lines
  common_fields
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

  #ORGANIZATIONS
  element(:new_organization_chart_code) { |b| b.cg_new_organization_chart_code('award') }
  element(:new_organization_code) { |b| b.cg_new_organization_code('award') }
  element(:new_organization_primary) { |b| b.cg_new_organization_primary('award') }
  element(:new_organization_active_indicator) { |b| b.cg_new_organization_active_indicator('award') }
  action(:add_new_organization) { |b| b.cg_add_new_organization('award') }
  action(:update_organization_code) { |l=0, b| b.cg_update_organization_code('award', l) }
  action(:update_organization_chart_code) { |l=0, b| b.cg_update_organization_chart_code('award', l) }
  action(:update_organization_primary) { |l=0, b| b.cg_update_organization_primary('award', l) }
  action(:update_organization_active_indicator) { |l=0, b| b.cg_update_organization_active_indicator('award', l) }

  element(:old_organization_primary) { |l=0, b| b.cg_old_organization_primary('award', l) }
  element(:old_organization_active_indicator) { |l=0, b| b.cg_old_organization_active_indicator('award', l) }
  action(:delete_organization) { |l=0, b| b.cg_delete_organization('award', l) }
  action(:old_organization_chart_code) { |l=0, b| b.cg_old_organization_chart_code('award', l) }
  action(:old_organization_code) { |l=0, b| b.cg_old_organization_code('award', l) }
  action(:result_organization_code) { |l=0, b| b.cg_result_organization_code('award', l) }
  action(:result_organization_chart_code) { |l=0, b| b.cg_result_organization_chart_code('award', l) }


  #PROJECT DIRECTOR
  element(:new_project_director_principal_name) { |b| b.cg_new_project_director_principal_name('award') }

  element(:new_project_director_primary) { |b| b.cg_new_project_director_primary('award') }
  element(:new_project_director_title) { |b| b.cg_new_project_director_title('award') }
  element(:new_project_director_active_indicator) { |b| b.cg_new_project_director_active_indicator('award') }
  action(:add_new_project_director) { |b| b.cg_add_new_project_director('award') }
  action(:delete_project_director) { |i=0, b| b.cg_delete_project_director('award', i) }
  action(:update_project_director_principal_name) { |i=0, b| b.cg_update_project_director_principal_name('award', i) }
  action(:update_project_director_primary) { |i=0, b| b.cg_update_project_director_primary('award', i) }
  action(:update_project_director_title) { |i=0, b| b.cg_update_project_director_title('award', i) }
  action(:update_project_director_active_indicator) { |i=0, b| b.cg_update_project_director_active_indicator('award', i) }
  action(:old_project_director_principal_name) { |i=0, b| b.cg_old_project_director_principal_name('award', i) }
  action(:old_project_director_primary) { |i=0, b| b.cg_old_project_director_primary('award', i) }
  action(:old_project_director_title) { |i=0, b| b.cg_old_project_director_title('award', i) }
  action(:old_project_director_active_indicator) { |i=0, b| b.cg_old_project_director_active_indicator('award', i) }


  #SUBCONTRACTORS
  element(:new_subcontractor_number) { |b| b.cg_new_subcontractor_number('award') }
  element(:new_subcontractor_description) { |b| b.cg_new_subcontractor_description('award') }
  element(:new_subcontractor_amount) { |b| b.cg_new_subcontractor_amount('award') }
  element(:new_subcontractor_active_indicator) { |b| b.cg_new_subcontractor_active_indicator('award') }
  action(:add_new_subcontractor) { |b| b.cg_add_new_subcontractor('award') }
  action(:delete_subcontractor) { |i=0, b| b.cg_delete_subcontractor('award', i) }
  element(:update_subcontractor_number) { |i=0, b| b.cg_update_subcontractor_number('award', i) }
  element(:update_subcontractor_description) { |i=0, b| b.cg_update_subcontractor_description('award', i) }
  element(:update_subcontractor_amount) { |i=0, b| b.cg_update_subcontractor_amount('award', i) }
  element(:update_subcontractor_active_indicator) { |i=0, b| b.cg_update_subcontractor_active_indicator('award', i) }
  value(:old_subcontractor_description) { |i=0, b| b.cg_old_subcontractor_description('award', i) }
  value(:old_subcontractor_number) { |i=0, b| b.cg_old_subcontractor_number('award', i) }
  value(:old_subcontractor_amount) { |i=0, b| b.cg_old_subcontractor_amount('award', i) }
  value(:old_subcontractor_active_indicator) { |i=0, b| b.cg_old_subcontractor_active_indicator('award', i) }
  value(:result_subcontractor_number) { |i=0, b| b.cg_result_subcontractor_number('award', i) }
end
