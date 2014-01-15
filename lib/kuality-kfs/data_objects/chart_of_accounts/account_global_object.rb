class AccountGlobalExtendedAttributesObject < DataObject
  # This super-class provides an overridable target for institutions to
  # inject extended attributes into an AccountGlobalObject. Please provide the
  # overrides in your institution's project.
end

class AccountGlobalObject < AccountGlobalExtendedAttributesObject

#  include Navigation
#  include DateFactory
  include StringFactory


  attr_accessor :description, :fo_principal_name, :supervisor_principal_name,
                :org_cd, :sub_fnd_group_code, :acct_expire_date,
                :postal_code, :city, :state, :address,
                :contintuation_coa_code, :contintuation_acct_number, :income_stream_financial_cost_cd, :income_stream_account_number,
                :cfda_number,  :higher_ed_funct_cd, :sufficient_funds_cd,
                :trans_processing_sufficient_funds_code, :labor_benefit_rate_category_code,
                :new_chart_code, :new_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(20, 'AFT'),
        new_chart_code:           'IT - Ithaca Campus', #TODO grab this from config file
        new_number:               '1000710', #TODO get from config
        supervisor_principal_name:  'jaraujo',
        manager_principal_name: 'warriaga',
        org_cd:               'BI',
        sub_fnd_group_code:   '',
        acct_expire_date:     '',
        postal_code:            '14853',
        city:                 'Ithaca',
        state:                'NY',
        address:              'Cornell University',
        contintuation_coa_code: '',
        contintuation_acct_number: '',
        income_stream_financial_cost_cd:  'IT - Ithaca Campus',
        income_stream_account_number:     '0142900',
        cfda_number:          '',
        higher_ed_funct_cd:   '',
        sufficient_funds_cd:    'C - Consolidation',
        trans_processing_sufficient_funds_code: '',
        labor_benefit_rate_category_code: ''

        #organization_code: '00*'

    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).account_global
    on AccountGlobalPage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :fo_principal_name, :supervisor_principal_name,
               :org_cd, :sub_fnd_group_code, :acct_expire_date,
               :postal_code, :city, :state, :address,
               :contintuation_coa_code, :contintuation_acct_number, :income_stream_financial_cost_cd, :income_stream_account_number,
               :cfda_number,  :higher_ed_funct_cd, :sufficient_funds_cd,
               :trans_processing_sufficient_funds_code, :labor_benefit_rate_category_code,
               :new_chart_code, :new_number
      super # For now, overriding the super#create should only do what is required to fill out extended attributes

      page.add_account_detail
      page.save
      @document_id = page.document_id
    end
  end

  def save
    on(AccountGlobalPage).save
  end

  def submit
    on(AccountGlobalPage).submit
  end

  def add_multiple_accounting_lines
    if !@add_multiple_accounting_lines.nil?
      on(AccountGlobalPage).add_multiple_accounting_lines
      on AccountGlobalLookupPage do |page|
        page.account_number.fit @search_account_number
        page.search
        page.select_all_rows_from_this_page
        page.return_selected_results
      end
    end
  end
end