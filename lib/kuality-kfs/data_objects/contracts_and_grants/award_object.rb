class AwardObject < KFSDataObject

  include AwardAccountLinesMixin
  include OrganizationLinesMixin
  include ProjectDirectorLinesMixin
  include SubcontractorLinesMixin

  attr_accessor :agency_number, :status, :project_title, :start_date, :stop_date, :direct_cost_amount, :indirect_cost_amount,
                :entry_date, :award_type, :purpose_code,:grant_number, :grant_description, :proposal_number

  def defaults
    super.merge({
                    status:                  'AC-AMNT PD COMPL',
                    start_date:              yesterday[:date_w_slashes],
                    stop_date:               in_a_year[:date_w_slashes],
                    entry_date:              right_now[:date_w_slashes],
                    award_type:              'N - New',
                    grant_description:       'CON - Contract'
                })
    .merge(default_award_accounts)
    .merge(default_organizations)
    .merge(default_project_directors)
    .merge(default_subcontractors)
    .merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_AWARD))
  end

  def build

    visit(MainPage).award
    on(AwardLookupPage).create_new
    on AwardPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description,
               :status, :start_date, :stop_date, :entry_date, :grant_description, :purpose_code
    end
  end

  def absorb!(target=:new)
    super
    on(AwardPage).expand_all
    case target
      when :new; update_options(pull_new_award_data)
      when :old; update_options(pull_old_award_data)
    end

    update_line_objects_from_page!(target)
  end

  # @return [Hash] The return values of attributes for the old award
  def pull_old_award_data

    pulled_award = Hash.new
    on AwardPage do |ap|
      pulled_award = {
          agency_number:          ap.old_agency_number,
          status:                 ap.old_status,
          project_title:          ap.old_project_title,
          start_date:             ap.old_start_date,
          stop_date:              ap.old_stop_date,
          direct_cost_amount:     ap.old_direct_cost_amount,
          indirect_cost_amount:   ap.old_indirect_cost_amount,
          entry_date:             ap.old_entry_date,
          award_type:             ap.old_award_type,
          purpose_code:           ap.old_purpose_code,
          grant_number:           ap.old_grant_number,
          grant_description:      ap.old_grant_description,
          proposal_number:        ap.old_proposal_number
      }
    end
    pulled_award.merge(pull_award_extended_data(:old))
  end

  # @return [Hash] The return values of attributes for the new Award
  def pull_new_award_data
    pulled_award = Hash.new
    on AwardPage do |ap|
      pulled_award = {
          agency_number:          ap.agency_number,
          status:                 ap.status,
          project_title:          ap.project_title,
          start_date:             ap.start_date,
          stop_date:              ap.stop_date,
          direct_cost_amount:     ap.direct_cost_amount,
          indirect_cost_amount:   ap.indirect_cost_amount,
          entry_date:             ap.entry_date,
          award_type:             ap.award_type,
          purpose_code:           ap.purpose_code,
          grant_number:           ap.grant_number,
          grant_description:      ap.grant_description
      }
    end
    pulled_award.merge(pull_award_extended_data(:new))
  end

  # @return [Hash] The return values of extended attributes for the old award
  # @param [Symbol] target The set of award data to pull in
  def pull_award_extended_data(target=:new)
    Hash.new
  end

  def update(opts={})
    puts 'award edit', opts
    on AwardPage do |page|
      edit_fields opts, page, :agency_number, :status, :project_title, :start_date, :stop_date, :direct_cost_amount, :indirect_cost_amount,
                  :entry_date, :award_type, :purpose_code,:grant_number, :grant_description
    end
    update_options(opts)
  end
  alias_method :edit, :update

  def pick_proposal(proposal)

    on(AwardPage).proposal_search
    on ProposalLookupPage do |page|
      page.proposal_number.fit proposal.proposal_number
      page.search
      page.return_value_links.first.click
      page.use_new_tab
      page.close_parents
    end
    @proposal_number = on(AwardPage).proposal_number

  end

  def view_via(mode=:doc_search)
    case mode
      when :doc_search
        view
      when :inquiry
        visit(MainPage).award
        on AwardLookupPage do |alp|
          alp.proposal_number.fit @proposal_number
          alp.grant_number.fit    @grant_number
          alp.search
          alp.view_award_random # There should either be one or none, right?
        end
      else
        raise ArgumentError, "Unknown view mode (#{mode}) requested!"
    end
  end
end

