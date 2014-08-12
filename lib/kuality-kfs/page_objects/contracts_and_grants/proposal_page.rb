class ProposalPage < KFSBasePage

  #PROPOSAL MAINTENANCE - OLD NEW
  element(:status) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalStatusCode') }
  alias_method :new_status, :status
  element(:proposal_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalNumber') }
  alias_method :new_proposal_number, :proposal_number
  element(:agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
  alias_method :new_agency_number, :agency_number
  element(:project_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalProjectTitle') }
  alias_method :new_project_title, :project_title
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalBeginningDate') }
  alias_method :new_start_date, :start_date
  element(:stop_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalEndingDate') }
  alias_method :new_stop_date, :stop_date
  element(:direct_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDirectCostAmount') }
  alias_method :new_direct_cost_amount, :direct_cost_amount
  element(:indirect_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalIndirectCostAmount') }
  alias_method :new_indirect_cost_amount, :indirect_cost_amount
  element(:submission_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalSubmissionDate') }
  alias_method :new_submission_date, :submission_date
  element(:award_type) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalAwardTypeCode') }
  alias_method :new_award_type, :award_type
  element(:purpose) { |b| b.frm.select('document.newMaintainableObject.proposalPurposeCode') }
  alias_method :new_purpose, :purpose
  element(:grant_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.grantNumber') }
  alias_method :new_grant_number, :grant_number
  element(:federal_pass_through) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.proposalFederalPassThroughIndicator') }
  alias_method :new_federal_pass_through, :federal_pass_through
  element(:federal_pass_through_agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.federalPassThroughAgencyNumber') }
  alias_method :new_federal_pass_through_agency_number, :federal_pass_through_agency_number
  element(:cfda_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.cfdaNumber') }
  alias_method :new_cfda_number, :cfda_number
  element(:fellow_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalFellowName') }
  alias_method :new_fellow_name, :fellow_name
  element(:due_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDueDate') }
  alias_method :new_due_date, :due_date
  element(:rejected_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalRejectedDate') }
  alias_method :new_rejected_date, :rejected_date

  element(:proposal_active_date) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  alias_method :new_proposal_active_date, :proposal_active_date

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