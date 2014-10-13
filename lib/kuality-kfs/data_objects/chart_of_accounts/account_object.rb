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
      fill_out page, *(self.class.attributes -
                       self.class.read_only_attributes -
                       self.class.icra_mixin_attributes) # We don't have any special attribute sections, so we should be able to throw them all in.
    end
  end

  def edit(opts={})
    super # Edit anything editable in KFSDataObject

    # Because AccountObject::attributes we're not doing anything fancy, we can just do this:
    on(AccountPage) { |p| edit_fields opts, p, *(self.class.attributes -
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
  end

  include IndirectCostRecoveryLinesMixin

end