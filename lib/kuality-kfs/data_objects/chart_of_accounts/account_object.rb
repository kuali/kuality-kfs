class AccountObject < KFSDataObject

  attr_accessor :description, :chart_code, :number, :name, :org_cd, :campus_cd, :effective_date,
                :postal_cd, :city, :state, :address,
                :type_cd, :sub_fnd_group_cd, :higher_ed_funct_cd, :restricted_status_cd,
                :fo_principal_name, :supervisor_principal_name, :manager_principal_name,
                :budget_record_level_cd, :sufficient_funds_cd,
                :expense_guideline_text, :income_guideline_txt, :purpose_text,
                :income_stream_financial_cost_cd, :income_stream_account_number, :labor_benefit_rate_cat_code

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           'IT', #TODO grab this from config file
        number:               random_alphanums(7),
        name:                 random_alphanums(10),
        org_cd:               '01G0',
        campus_cd:            'IT - Ithaca', #TODO grab this from config file
        effective_date:       '01/01/2010',
        postal_cd:            '14853', #TODO grab this from config file
        city:                 'Ithaca', #TODO grab this from config file
        state:                'NY', #TODO grab this from config file
        address:              'Cornell University', #TODO grab this from config file
        type_cd:              'CC - Contract College', #TODO grab this from config file
        sub_fnd_group_cd:     'ADMSYS',
        higher_ed_funct_cd:   '4000',
        restricted_status_cd: 'U - Unrestricted',
        fo_principal_name:    'dh273',
        supervisor_principal_name:  'ccs1',
        manager_principal_name: 'aap98',
        budget_record_level_cd: 'C - Consolidation',
        sufficient_funds_cd:    'C - Consolidation',
        expense_guideline_text: 'expense guideline text',
        income_guideline_txt:   'incomde guideline text',
        purpose_text:           'purpose text',
        income_stream_financial_cost_cd:  'IT - Ithaca Campus',
        income_stream_account_number:     '1000710',
        labor_benefit_rate_cat_code:      'CC'
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).account
    on(AccountLookupPage).create
    on AccountPage do |page|
      @document_id = page.document_id
      page.expand_all
      page.type_cd.fit @type_cd
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :number, :name, :org_cd, :campus_cd,
               :effective_date, :postal_cd, :city, :state, :address, :sub_fnd_group_cd,
               :higher_ed_funct_cd, :restricted_status_cd, :fo_principal_name, :supervisor_principal_name,
               :manager_principal_name, :budget_record_level_cd, :sufficient_funds_cd, :expense_guideline_text,
               :income_guideline_txt, :purpose_text, :income_stream_financial_cost_cd, :income_stream_account_number

      press_form_button page
    end
  end

  def save
    on(AccountPage).save
  end

  def submit
    on(AccountPage).submit
  end

  def blanket_approve
    on(AccountPage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(AccountPage).copy
  end
end