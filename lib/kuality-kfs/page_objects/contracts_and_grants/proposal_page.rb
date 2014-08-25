class ProposalPage < ContractAndGrantBasePage

  cg_base
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

end