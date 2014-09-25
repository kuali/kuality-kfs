class ProposalObject < KFSDataObject

  include OrganizationLinesMixin
  include ProjectDirectorLinesMixin
  include SubcontractorLinesMixin

  attr_accessor :proposal_number, :agency_number, :status, :project_title, :start_date, :stop_date, :direct_cost_amount, :indirect_cost_amount,
                :submission_date, :award_type, :purpose_code,:grant_number, :federal_pass_through, :federal_pass_through_agency_number,
                :cfda_number, :fellow_name, :due_date, :rejected_date, :proposal_active_date

  def defaults
    super.merge({
                    proposal_number:         rand(10000000..89999999), # up to 12 digits
                    agency_number:           get_kuali_business_object('KFS-SYS','Agency','active=Y')['agencyNumber'].sample,
                    project_title:           random_alphanums(40, 'AFT'),
                    status:                  'AC-AMNT PD COMPL',
                    start_date:              yesterday[:date_w_slashes],
                    stop_date:               in_a_year[:date_w_slashes],
                    submission_date:         right_now[:date_w_slashes],
                    award_type:              'N - New',
                    purpose_code:            'A-Academic Support',
                    direct_cost_amount:      '100',
                    indirect_cost_amount:    '100'
                })
    .merge(default_organizations)
    .merge(default_project_directors)
    .merge(default_subcontractors)
    .merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_PROPOSAL))
  end

  def build
    visit(MainPage).proposal
    on(ProposalLookupPage).create_new
    on ProposalPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description,
               :proposal_number, :agency_number, :status, :project_title, :start_date, :stop_date, :direct_cost_amount, :indirect_cost_amount,
               :submission_date, :award_type, :purpose_code
    end
  end

  def absorb!(target=:new)
    super
    on(ProposalPage).expand_all
    case target
      when :new; update_options(pull_new_proposal_data)
      when :old; update_options(pull_old_proposal_data)
    end

    update_line_objects_from_page!(target)
  end

  # @return [Hash] The return values of attributes for the old proposal
  def pull_old_proposal_data
    pulled_proposal = Hash.new
    on ProposalPage do |pp|
      pulled_proposal = {
          agency_number:          pp.old_agency_number,
          status:                 pp.old_status,
          project_title:          pp.old_project_title,
          start_date:             pp.old_start_date,
          stop_date:              pp.old_stop_date,
          direct_cost_amount:     pp.old_direct_cost_amount,
          indirect_cost_amount:   pp.old_indirect_cost_amount,
          submission_date:        pp.old_submission_date,
          award_type:             pp.old_award_type,
          purpose_code:           pp.old_purpose_code,
          proposal_number:        pp.old_proposal_number
      }
    end
    pulled_proposal.merge(pull_proposal_extended_data(:old))
  end

  # @return [Hash] The return values of attributes for the new Vendor
  def pull_new_proposal_data
    pulled_proposal = Hash.new
    on ProposalPage do |pp|
      pulled_vendor = {
          proposal_number:        pp.proposal_number,
          agency_number:          pp.agency_number,
          status:                 pp.status,
          project_title:          pp.project_title,
          start_date:             pp.start_date,
          stop_date:              pp.stop_date,
          direct_cost_amount:     pp.direct_cost_amount,
          indirect_cost_amount:   pp.indirect_cost_amount,
          submission_date:        pp.submission_date,
          award_type:             pp.award_type,
          purpose_code:           pp.purpose_code
      }
    end
    pulled_proposal.merge(pull_proposal_extended_data(:new))
  end

  # @return [Hash] The return values of extended attributes for the old proposal
  # @param [Symbol] target The set of proposal data to pull in
  def pull_proposal_extended_data(target=:new)
    Hash.new
  end


end