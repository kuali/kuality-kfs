class OrganizationReviewRoleObject < KFSDataObject

  attr_accessor :chart_code, :org_code, :doc_type, :review_types,
                :from_amount, :to_amount, :accounting_line_override_code, :principal_name,
                :namespace, :role_name, :group_namespace, :group_name, :action_type_code,
                :priority_number, :action_policy_code, :force_action, :action_from_date, :action_to_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:            random_alphanums(40, 'AFT'),
        chart_code:             'IT', #TODO grab this from config file
        org_code:               '017D', #TODO grab this from config file
        doc_type:               'KFST',
        action_type_code:       'FYI',
        action_policy_code:     'FIRST'
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).organization
    on(OrganizationReviewLookupPage).create
    on OrganizationReviewRolePage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :org_code, :doc_type, :action_type_code, :action_policy_code

      press_form_button page
    end
  end

  def save
    on(OrganizationReviewRolePage).save
  end

  def submit
    on(OrganizationReviewRolePage).submit
  end

  def blanket_approve
    on(OrganizationReviewRolePage).blanket_approve
  end

  def view
    @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  end

  def copy
    on(OrganizationReviewRolePage).copy
  end

end