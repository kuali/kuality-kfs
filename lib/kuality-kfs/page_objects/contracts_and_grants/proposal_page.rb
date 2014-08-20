class ProposalPage < ContractAndGrantPage

  organization_lines
  project_director_lines
  subcontractor_lines
  common_fields
    #PROPOSAL MAINTENANCE - OLD NEW
  element(:status) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalStatusCode') }
  element(:proposal_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalNumber') }
  element(:project_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalProjectTitle') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalBeginningDate') }
  element(:stop_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalEndingDate') }
  element(:direct_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDirectCostAmount') }
  element(:indirect_cost_amount) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalIndirectCostAmount') }
  element(:submission_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalSubmissionDate') }

  element(:purpose_code) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalPurposeCode') }

  element(:federal_pass_through) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.proposalFederalPassThroughIndicator') }

  element(:federal_pass_through_agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.federalPassThroughAgencyNumber') }
  element(:cfda_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.cfdaNumber') }
  element(:fellow_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalFellowName') }
  element(:due_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalDueDate') }
  element(:rejected_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposalRejectedDate') }

  element(:proposal_active_date) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
  element(:old_status) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalStatusCode.div').text.strip }
  element(:old_project_title) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalProjectTitle.div').text.strip }
  element(:old_start_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalBeginningDate.div').text.strip }
  element(:old_stop_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalBeginningDate.div').text.strip }
  element(:old_direct_cost_amount) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalDirectCostAmount.div').text.strip }
  element(:old_indirect_cost_amount) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalIndirectCostAmount.div').text.strip }
  element(:old_submission_date) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalSubmissionDate.div').text.strip }
  element(:old_purpose_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalPurposeCode.div').text.strip }

  #ORGANIZATIONS
  element(:new_organization_chart_code) { |b| b.cg_new_organization_chart_code('proposal') }
  element(:new_organization_code) { |b| b.cg_new_organization_code('proposal') }
  element(:new_organization_primary) { |b| b.cg_new_organization_primary('proposal') }
  element(:new_organization_active_indicator) { |b| b.cg_new_organization_active_indicator('proposal') }
  action(:add_new_organization) { |b| b.cg_add_new_organization('proposal') }
  action(:update_organization_code) { |l=0, b| b.cg_update_organization_code('proposal', l) }
  action(:update_organization_chart_code) { |l=0, b| b.cg_update_organization_chart_code('proposal', l) }
  action(:update_organization_primary) { |l=0, b| b.cg_update_organization_primary('proposal', l) }
  action(:update_organization_active_indicator) { |l=0, b| b.cg_update_organization_active_indicator('proposal', l) }

  element(:old_organization_primary) { |l=0, b| b.cg_old_organization_primary('proposal', l) }
  element(:old_organization_active_indicator) { |l=0, b| b.cg_old_organization_active_indicator('proposal', l) }
  action(:delete_organization) { |l=0, b| b.cg_delete_organization('proposal', l) }
  action(:old_organization_chart_code) { |l=0, b| b.cg_old_organization_chart_code('proposal', l) }
  action(:old_organization_code) { |l=0, b| b.cg_old_organization_code('proposal', l) }
  action(:result_organization_code) { |l=0, b| b.cg_result_organization_code('proposal', l) }
  action(:result_organization_chart_code) { |l=0, b| b.cg_result_organization_chart_code('proposal', l) }

  #PROJECT DIRECTOR
  element(:new_project_director_principal_name) { |b| b.cg_new_project_director_principal_name('proposal') }
  element(:new_project_director_primary) { |b| b.cg_new_project_director_primary('proposal') }
  element(:new_project_director_title) { |b| b.cg_new_project_director_title('proposal') }
  element(:new_project_director_active_indicator) { |b| b.cg_new_project_director_active_indicator('proposal') }
  action(:add_new_project_director) { |b| b.cg_add_new_project_director('proposal') }
  action(:delete_project_director) { |i=0, b| b.cg_delete_project_director('proposal', i) }
  action(:update_project_director_principal_name) { |i=0, b| b.cg_update_project_director_principal_name('proposal', i) }
  action(:update_project_director_primary) { |i=0, b| b.cg_update_project_director_primary('proposal', i) }
  action(:update_project_director_title) { |i=0, b| b.cg_update_project_director_title('proposal', i) }
  action(:update_project_director_active_indicator) { |i=0, b| b.cg_update_project_director_active_indicator('proposal', i) }
  action(:old_project_director_principal_name) { |i=0, b| b.cg_old_project_director_principal_name('proposal', i) }
  action(:old_project_director_primary) { |i=0, b| b.cg_old_project_director_primary('proposal', i) }
  action(:old_project_director_title) { |i=0, b| b.cg_old_project_director_title('proposal', i) }
  action(:old_project_director_active_indicator) { |i=0, b| b.cg_old_project_director_active_indicator('proposal', i) }

  #SUBCONTRACTORS
  element(:new_subcontractor_number) { |b| b.cg_new_subcontractor_number('proposal') }
  element(:new_subcontractor_description) { |b| b.cg_new_subcontractor_description('proposal') }
  element(:new_subcontractor_amount) { |b| b.cg_new_subcontractor_amount('proposal') }
  element(:new_subcontractor_active_indicator) { |b| b.cg_new_subcontractor_active_indicator('proposal') }
  action(:add_new_subcontractor) { |b| b.cg_add_new_subcontractor('proposal') }
  action(:delete_subcontractor) { |i=0, b| b.cg_delete_subcontractor('proposal', i) }
  element(:update_subcontractor_number) { |i=0, b| b.cg_update_subcontractor_number('proposal', i) }
  element(:update_subcontractor_description) { |i=0, b| b.cg_update_subcontractor_description('proposal', i) }
  element(:update_subcontractor_amount) { |i=0, b| b.cg_update_subcontractor_amount('proposal', i) }
  element(:update_subcontractor_active_indicator) { |i=0, b| b.cg_update_subcontractor_active_indicator('proposal', i) }
  value(:old_subcontractor_description) { |i=0, b| b.cg_old_subcontractor_description('proposal', i) }
  value(:old_subcontractor_number) { |i=0, b| b.cg_old_subcontractor_number('proposal', i) }
  value(:old_subcontractor_amount) { |i=0, b| b.cg_old_subcontractor_amount('proposal', i) }
  value(:old_subcontractor_active_indicator) { |i=0, b| b.cg_old_subcontractor_active_indicator('proposal', i) }
  value(:result_subcontractor_number) { |i=0, b| b.cg_result_subcontractor_number('proposal', i) }


end