class ParameterObject < MaintenanceObject

  attr_accessor :namespace_code, :component, :application_id,
                :parameter_name, :parameter_value, :parameter_description,
                :parameter_type_code, :parameter_constraint_code_allowed, :parameter_constraint_code_denied

  def initialize(browser, opts={})
    @browser = browser
    defaults = { description: random_alphanums(40, 'AFT') }
    set_options(defaults.merge(opts))
  end

  def build
    visit(AdministrationPage).parameter
    prep_page
    on ParameterPage do |page|
      fill_out page, :description, :namespace_code, :component, :application_id,
                     :parameter_name, :parameter_value, :parameter_description,
                     :parameter_type_code, :parameter_constraint_code_allowed, :parameter_constraint_code_denied
    end
  end

  # Edit the Parameter. Note: You'll need to already be on the Parameter's edit page.
  def update(opts={})
    prep_page
    on ParameterPage do |page|
      edit_fields opts, page, :description, :parameter_value, :parameter_description,:parameter_type_code,
                              :parameter_constraint_code_allowed, :parameter_constraint_code_denied
    end
  end

end
