class AccountObject < KFSDataObject

                # == Account Maintenance tab ==
  attr_accessor :chart_code, :number, :name, :organization_code, :campus_code,
                :effective_date, :account_expiration_date,
                :postal_code, :city, :state, :address, :closed,
                :type_code, :sub_fund_group_code, :higher_ed_funct_code, :restricted_status_code,
                # == Account Responsibility tab ==
                :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                :budget_record_level_code, :sufficient_funds_code,
                :income_stream_financial_cost_code, :income_stream_account_number,
                :continuation_account_number, :continuation_chart_code,
                # == Guidelines and Purpose tab ==
                :expense_guideline_text, :income_guideline_text, :purpose_text,
                # == Contracts and Grants tab ==
                :contract_control_chart_of_accounts_code, :contract_control_account_number,
                :account_icr_type_code, :indirect_cost_rate, :cfda_number, :cg_account_responsibility_id,
                :invoice_frequency_code, :invoice_type_code, :everify_indicator, :cost_share_for_project_number

  def defaults
    super.merge({
                  chart_code:                        get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
                  number:                            random_alphanums(7),
                  name:                              random_alphanums(10),
                  organization_code:                 '01G0',  #TODO replace with bootstrap data
                  campus_code:                       get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_CODE),
                  effective_date:                    '01/01/2010',
                  postal_code:                       get_random_postal_code('*'),
                  city:                              get_generic_city,
                  state:                             get_random_state_code,
                  address:                           get_generic_address_1,
                  type_code:                         get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_TYPE_CODE),
                  sub_fund_group_code:               'ADMSYS', #TODO replace with bootstrap data
                  higher_ed_funct_code:              '4000',   #TODO replace with bootstrap data
                  restricted_status_code:            'U - Unrestricted',  #TODO replace with bootstrap data
                  fo_principal_name:                 get_aft_parameter_value(ParameterConstants::DEFAULT_FISCAL_OFFICER),
                  supervisor_principal_name:         get_aft_parameter_value(ParameterConstants::DEFAULT_SUPERVISOR),
                  manager_principal_name:            get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER),
                  budget_record_level_code:          'C - Consolidation', #TODO replace with bootstrap data
                  sufficient_funds_code:             'C - Consolidation', #TODO replace with bootstrap data
                  expense_guideline_text:            'expense guideline text',
                  income_guideline_text:             'income guideline text',
                  purpose_text:                      'purpose text',
                  account_expiration_date:           '',
                  press:                             :save
                }).merge(default_icr_accounts)
                  .merge(get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ACCOUNT))
  end

  def build
    visit(MainPage).account
    on(AccountLookupPage).create
    on AccountPage do |page|
      page.expand_all
      page.type_code.fit @type_code # Gotta do this first or we get a modal
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, *((self.class.superclass.attributes -
                        self.class.superclass.read_only_attributes -
                        self.class.notes_and_attachments_tab_mixin_attributes) +
                       self.class.attributes -
                       self.class.read_only_attributes -
                       self.class.icra_mixin_attributes) # We don't have any special attribute sections, so we should be able to throw them all in.
    end
  end


  def edit(opts={})
    super # Edit anything editable in KFSDataObject

    # Because AccountObject::attributes we're not doing anything fancy, we can just do this:
    on(AccountPage) { |p| edit_fields opts, p, *((self.class.superclass.attributes -
                                                  self.class.superclass.read_only_attributes -
                                                  self.class.notes_and_attachments_tab_mixin_attributes) +
                                                 self.class.attributes -
                                                 self.class.read_only_attributes -
                                                 self.class.icra_mixin_attributes) }
    # This does mean that you can't update stuff from the ICRA Mixin via #edit, though.
    update_options(opts)
  end

  def absorb!(target={})
    super
    update_options(on(AccountPage).send("account_data_#{target.to_s}"))
    update_line_objects_from_page!(target == :original ? :old : target)
  end


  # Class Methods:
  class << self
    # Attributes that are required for a successful save/submit.
    # @return [Array] List of Symbols for attributes that are required
    def required_attributes
      superclass.required_attributes | [ :chart_code, :number, :name, :organization_code,
                :campus_code, :effective_date, :account_expiration_date,
                :postal_code, :city, :state, :address,
                :type_code, :sub_fund_group_code, :higher_ed_funct_code, :restricted_status_code,
                :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                :budget_record_level_code, :sufficient_funds_code,
                :expense_guideline_text, :income_guideline_text, :purpose_text ]
    end

    # Attributes that don't copy over to a new document's fields during a copy.
    # @return [Array] List of Symbols for attributes that aren't copied to the new side of a copy
    def uncopied_attributes
      superclass.uncopied_attributes | [:chart_code, :number, :effective_date]
    end


    # @param [String] code_and_description: String containing a code and description delimited by a single hyphen.
    # Description could contain one or more hyphens.
    #
    # @return [Hash] A hash of :code, :description where :code is the the portion of the string represented by everything
    # up to the first hyphen with trailing white space removed and :description is the portion of the string represented
    # by everything after the first hyphen with leading white space removed.
    def split_code_description_at_first_hyphen(code_and_description)
      split_data_array = code_and_description.to_s.split( /- */, 2)
      unless (split_data_array[0]).rstrip.nil?
        #there is trailing white space
        split_data_array[0] = (split_data_array[0]).rstrip
      end
      unless (split_data_array[1]).lstrip.nil?
        #there is leading white space
        split_data_array[1] = (split_data_array[1]).lstrip
      end
      code_description_hash = {
          code:         split_data_array[0],
          description:  split_data_array[1]
      }
    end


    # Used in method absorb_webservice_item! or can be called standalone
    # @param [Hash][Array] data_item Single array element from a WebService call for the data object in question.
    # @return [Hash] A hash of the object's data attributes and the values provided in the data_item.
    def webservice_item_to_hash(data_item)
      coa_code_descr_hash = split_code_description_at_first_hyphen(data_item['chartOfAccounts.codeAndDescription'][0])
      org_code_descr_hash = split_code_description_at_first_hyphen(data_item['organization.codeAndDescription'][0])
      sub_fund_code_descr_hash = split_code_description_at_first_hyphen(data_item['subFundGroup.codeAndDescription'][0])
      fin_higher_ed_code_descr_hash = split_code_description_at_first_hyphen(data_item['financialHigherEdFunction.codeAndDescription'][0])

      data_hash = {
          description:                          'WebService provided data',
          chart_code:                           coa_code_descr_hash[:code],
          number:                               data_item['accountNumber'][0],
          name:                                 data_item['accountName'][0],
          organization_code:                    org_code_descr_hash[:code],
          campus_code:                          data_item['accountPhysicalCampusCode'][0],
          effective_date:                       data_item['accountEffectiveDate'][0],
          postal_code:                          data_item['accountZipCode'][0],
          city:                                 data_item['accountCityName'][0],
          state:                                data_item['accountStateCode'][0],
          address:                              data_item['accountStreetAddress'][0],
          type_code:                            data_item['accountTypeCode'][0],
          sub_fund_group_code:                  sub_fund_code_descr_hash[:code],
          higher_ed_funct_code:                 fin_higher_ed_code_descr_hash[:code],
          restricted_status_code:               data_item['accountRestrictedStatusCode'][0],
          fo_principal_name:                    data_item['accountFiscalOfficerUser.principalName'][0],
          supervisor_principal_name:            data_item['accountSupervisoryUser.principalName'][0],
          manager_principal_name:               data_item['accountManagerUser.principalName'][0],
          budget_record_level_code:             data_item['budgetRecordingLevelCode'][0],
          sufficient_funds_code:                data_item['accountSufficientFundsCode'][0],
          expense_guideline_text:               data_item['accountGuideline.accountExpenseGuidelineText'][0],
          income_guideline_txt:                 data_item['accountGuideline.accountIncomeGuidelineText'][0],
          purpose_text:                         data_item['accountGuideline.accountPurposeText'][0],
          labor_benefit_rate_cat_code:          data_item['laborBenefitRateCategoryCode'][0],
          account_expiration_date:              data_item['accountExpirationDate'][0],
          closed:                               data_item['closed'][0],
          income_stream_account_number:         data_item['incomeStreamAccountNumber'][0],
          income_stream_financial_cost_code:    data_item['incomeStreamFinancialCoaCode'][0]
      }.merge!(extended_webservice_item_to_hash(data_item))
    end

    # Override this method if you have site-specific extended attributes.
    def extended_webservice_item_to_hash(data_item)
      Hash.new
    end

  end #class<<self

  include IndirectCostRecoveryLinesMixin

end