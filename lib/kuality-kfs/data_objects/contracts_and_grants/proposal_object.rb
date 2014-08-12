class ProposalObject < KFSDataObject

  #include AddressLinesMixin
  #include PhoneNumberLinesMixin
  #include ContactLinesMixin
  #include ContractLinesMixin
  #include SearchAliasLinesMixin

  attr_accessor :proposal_number, :agency_number, :status, :project_title, :start_date, :stop_date, :direct_cost_amount, :indirect_cost_amount,
                :submission_date, :award_type, :purpose,:grant_number, :federal_pass_through, :federal_pass_through_agency_number,
                :cfda_number, :fellow_name, :due_date, :rejected_date, :proposal_active_date

  def defaults
    super.merge({
                    proposal_number:         rand(10000000..89999999), # up to 12 digits
                    agency_number:           get_kuali_business_object,
                    project_title:           random_alphanums(40, 'AFT'),
                    status:                  'AC-AMNT PD COMPL',
                    start_date:              yesterday[:date_w_slashes],
                    stop_date:               in_a_year[:date_w_slashes],
                    submission_date:         right_now[:date_w_slashes],
                    award_type:              'N - New',
                    purpose:                 'A-Academic Support'
                }).merge(default_addresses)
    .merge(default_contacts)
    .merge(default_contracts)
    .merge(default_phone_numbers)
    .merge(default_search_aliases)
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
               :submission_date, :award_type, :purpose
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
    on ProposalPage do |vp|
      pulled_proposal = {
          vendor_number: vp.old_vendor_number,
          vendor_name:   vp.old_vendor_name.empty? ? "#{vp.old_vendor_last_name}, #{vp.old_vendor_first_name}" : vp.old_vendor_name,
          vendor_last_name:  vp.old_vendor_last_name,
          vendor_first_name: vp.old_vendor_first_name,
          vendor_type: vp.old_vendor_type,
          foreign:     vp.old_foreign,
          tax_number:  vp.old_tax_number,
          tax_number_type_fein: vp.old_tax_number_type_fein,
          tax_number_type_ssn:  vp.old_tax_number_type_ssn,
          tax_number_type_none: vp.old_tax_number_type_none,
          ownership:   vp.old_ownership,
          w9_received: vp.old_w9_received
      }
    end
    pulled_proposal.merge(pull_proposal_extended_data(:old))
  end

  # @return [Hash] The return values of attributes for the new Vendor
  def pull_new_proposal_data
    pulled_proposal = Hash.new
    on ProposalPage do |vp|
      pulled_vendor = {
          vendor_number: vp.new_vendor_number,
          vendor_name: vp.new_vendor_name.value.strip,
          vendor_last_name:  vp.new_vendor_last_name.value.strip,
          vendor_first_name: vp.new_vendor_first_name.value.strip,
          vendor_type: vp.new_vendor_type.value.strip,
          foreign:     vp.new_foreign.selected_options.first.text.strip,
          tax_number:  vp.new_tax_number.value.strip,
          tax_number_type_fein: vp.new_tax_number_type_fein.value.strip,
          tax_number_type_ssn:  vp.new_tax_number_type_ssn.value.strip,
          tax_number_type_none: vp.new_tax_number_type_none.value.strip,
          ownership:   vp.new_ownership.selected_options.first.text.strip,
          w9_received: vp.new_w9_received.selected_options.first.text.strip
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