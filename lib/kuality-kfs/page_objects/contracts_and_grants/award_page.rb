class AwardPage < KFSBasePage

  #Award MAINTENANCE - OLD NEW
  element(:status) { |b| b.frm.select(name: 'document.newMaintainableObject.awardStatusCode') }

  element(:agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
  element(:project_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardProjectTitle') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardBeginningDate') }
  element(:stop_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardEndingDate') }
  element(:direct_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardDirectCostAmount') }
  element(:indirect_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardIndirectCostAmount') }
  element(:entry_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.awardEntryDate') }

  element(:award_type) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalAwardTypeCode') }
  element(:purpose) { |b| b.frm.select('document.newMaintainableObject.awardPurposeCode') }

  element(:grant_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposal.grantNumber') }
  element(:grant_description) { |b| b.frm.select(name: 'document.newMaintainableObject.grantDescriptionCode') }

  element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

  #Accounts
  element(:chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.awardAccounts.chartOfAccountsCode') }

  element(:account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardAccounts.accountNumber') }
  element(:account_project_director_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardAccounts.projectDirector.principalName') }

  element(:new_account_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardAccounts.active') }
  action(:add_new_organization) { |b| b.frm.button(id: /^methodToCall\.addLine\.awardAccounts/).click }

  element(:old_account_project_director_principal_name) { |l=0, b| b.frm.text_field(name: "document.newMaintainableObject.awardAccounts[#{l}].projectDirector.principalName") }
  element(:old_account_active_indicator) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.awardAccounts[#{l}].active") }

  #ORGANIZATIONS
  element(:chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.awardOrganizations.chartOfAccountsCode') }

  element(:organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardOrganizations.organizationCode') }

  element(:new_organization_primary) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardOrganizations.awardPrimaryOrganizationIndicator') }
  element(:new_organization_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardOrganizations.active') }
  action(:add_new_organization) { |b| b.frm.button(id: /^methodToCall\.addLine\.awardOrganizations/).click }

  element(:old_organization_primary) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.proposalOrganizations[#{l}].proposalPrimaryOrganizationIndicator") }
  element(:old_organization_active_indicator) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.proposalOrganizations[#{l}].active") }


  #PROJECT DIRECTOR
  element(:project_director_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardProjectDirectors.projectDirector.principalName') }

  element(:new_project_director_primary) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardProjectDirectors.proposalPrimaryProjectDirectorIndicator') }
  element(:new_project_director_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardProjectDirectors.proposalProjectDirectorProjectTitle') }
  element(:new_project_director_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardProjectDirectors.active') }
  action(:add_new_project_director) { |b| b.frm.button(id: /^methodToCall\.addLine\.awardProjectDirectors/).click }

  #SUBCONTRACTORS
  element(:new_subcontractor_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardSubcontractors.subcontractorNumber') }
  element(:new_subcontractor_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardSubcontractors.proposalSubcontractorDescription') }
  element(:new_subcontractor_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.awardSubcontractors.proposalSubcontractorAmount') }
  element(:new_subcontractor_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.awardProjectDirectors.active') }
  action(:add_subcontractor_director) { |b| b.frm.button(id: /^methodToCall\.addLine\.awardSubcontractors/).click }

end