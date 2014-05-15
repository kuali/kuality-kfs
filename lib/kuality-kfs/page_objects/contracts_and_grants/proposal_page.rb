class ProposalPage < KFSBasePage

  #PROPOSAL MAINTENANCE - OLD NEW
  element(:status) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalStatusCode') }

  element(:agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
  element(:project_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalProjectTitle') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalBeginningDate') }
  element(:stop_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalEndingDate') }
  element(:direct_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDirectCostAmount') }
  element(:indirect_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalIndirectCostAmount') }
  element(:submission_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalSubmissionDate') }

  element(:award_type) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalAwardTypeCode') }
  element(:purpose) { |b| b.frm.select('document.newMaintainableObject.proposalPurposeCode') }

  element(:grant_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.grantNumber') }

  element(:federal_pass_through) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.proposalFederalPassThroughIndicator') }

  element(:federal_pass_through_agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.federalPassThroughAgencyNumber') }
  element(:cfda_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.cfdaNumber') }
  element(:fellow_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalFellowName') }
  element(:due_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDueDate') }
  element(:rejected_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalRejectedDate') }

  element(:proposal_active_date) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

  #ORGANIZATIONS
  element(:chart_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.proposalOrganizations.chartOfAccountsCode') }

  element(:organization_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalOrganizations.organizationCode') }

  element(:new_organization_primary) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.proposalOrganizations.proposalPrimaryOrganizationIndicator') }
  element(:new_organization_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.proposalOrganizations.active') }
  action(:add_new_organization) { |b| b.frm.button(id: /^methodToCall\.addLine\.proposalOrganizations/).click }

  element(:old_organization_primary) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.proposalOrganizations[#{l}].proposalPrimaryOrganizationIndicator") }
  element(:old_organization_active_indicator) { |l=0, b| b.frm.checkbox(name: "document.newMaintainableObject.proposalOrganizations[#{l}].active") }

  #PROJECT DIRECTOR
  element(:project_director_principal_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalProjectDirectors.projectDirector.principalName') }

  element(:new_project_director_primary) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.proposalProjectDirectors.proposalPrimaryProjectDirectorIndicator') }
  element(:new_project_director_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalProjectDirectors.proposalProjectDirectorProjectTitle') }
  element(:new_project_director_active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.add.proposalProjectDirectors.active') }
  action(:add_new_project_director) { |b| b.frm.button(id: /^methodToCall\.addLine\.proposalProjectDirectors/).click }

  #SUBCONTRACTORS
  element(:subcontractor_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalSubcontractors.subcontractorNumber') }
  element(:subcontractor_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalSubcontractors.proposalSubcontractorDescription') }
  element(:subcontractor_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.proposalSubcontractors.proposalSubcontractorAmount') }

end