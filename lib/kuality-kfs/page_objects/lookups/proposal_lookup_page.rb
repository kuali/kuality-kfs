class ProposalLookupPage < Lookups

  active_radios

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  element(:agency_number) { |b| b.frm.text_field(name: 'agencyNumber') }
  element(:total_amount) { |b| b.frm.text_field(name: 'proposalTotalAmount') }
  element(:agency_reporting_name) { |b| b.frm.text_field(name: 'agency.reportingName') }

  element(:start_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_proposalBeginningDate') }
  element(:start_date_to) { |b| b.frm.text_field(name: 'proposalBeginningDate') }
  element(:stop_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_proposalEndingDate') }
  element(:stop_date_to) { |b| b.frm.text_field(name: 'proposalEndingDate') }
  element(:project_title) { |b| b.frm.text_field(name: 'proposalProjectTitle') }
  element(:grant_number) { |b| b.frm.text_field(name: 'grantNumber') }

  element(:status) { |b| b.frm.select(name: 'proposalStatusCode') }

  element(:federal_pass_through_agency_number) { |b| b.frm.text_field(name: 'federalPassThroughAgencyNumber') }

  element(:purpose) { |b| b.frm.select(name: 'proposalPurposeCode') }

  element(:fellow_name) { |b| b.frm.text_field(name: 'proposalFellowName') }
  element(:organization_code) { |b| b.frm.text_field(name: 'proposalOrganizations.organization.organizationCode') }
  element(:subcontractor_number) { |b| b.frm.text_field(name: 'proposalSubcontractors.subcontractor.subcontractorNumber') }
  element(:project_director_principal_name) { |b| b.frm.text_field(name: 'lookupPerson.principalName') }

end