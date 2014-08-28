class AwardLookupPage < Lookups

  active_radios

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  element(:agency_number) { |b| b.frm.text_field(name: 'agencyNumber') }
  element(:total_amount) { |b| b.frm.text_field(name: 'awardTotalAmount') }
  element(:start_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_awardBeginningDate') }
  element(:start_date_to) { |b| b.frm.text_field(name: 'awardBeginningDate') }
  element(:stop_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_awardEndingDate') }
  element(:stop_date_to) { |b| b.frm.text_field(name: 'awardEndingDate') }
  element(:project_title) { |b| b.frm.text_field(name: 'awardProjectTitle') }
  element(:grant_number) { |b| b.frm.text_field(name: 'proposal.grantNumber') }

  element(:grant_description) { |b| b.frm.select(name: 'grantDescriptionCode') }
  element(:status) { |b| b.frm.select(name: 'awardStatusCode') }

  element(:federal_pass_through_agency_number) { |b| b.frm.text_field(name: 'federalPassThroughAgencyNumber') }

  element(:purpose) { |b| b.frm.select(name: 'awardPurposeCode') }

  element(:subcontractor_number) { |b| b.frm.text_field(name: 'awardSubcontractors.subcontractor.subcontractorNumber') }
  element(:project_director_principal_name) { |b| b.frm.text_field(name: 'lookupPerson.principalName') }
  element(:organization_code) { |b| b.frm.text_field(name: 'awardOrganizations.organization.organizationCode') }
  element(:award_account_number) { |b| b.frm.text_field(name: 'awardAccounts.account.accountNumber') }
  element(:view_award_links) { |b| b.results_table.links(text: 'View Award') }
  action(:view_award_random) { |b| b.view_award_links[rand(b.view_award_links.length)].click; b.use_new_tab; b.close_parents }

end