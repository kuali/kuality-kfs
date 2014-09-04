class ContractGrantReportingCodeObject < KFSDataObject

  attr_accessor  :chart_code, :code, :name, :active_indicator

  DOC_INFO = { label: 'Contract Grant Reporting Code', type_code: 'OCGR' }

  def defaults
    super.merge({
                   chart_code:   get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
                   code:         random_alphanums(4),
                   name:         random_alphanums(9, 'Default CG Reporting Code Name ')
               })
  end

  # def initialize(browser, opts={})
  #   @browser = browser
  #   set_options(defaults.merge(opts))
  # end

  def build
    visit(MaintenancePage).cg_reporting_code
    on(ContractGrantsReportingCodeLookupPage).create_new
    on ContractGrantReportingCodePage do |page|
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :chart_code, :code, :name
    end
  end

  def absorb!(target=:new, action=:edit)
    super target
    on(ContractGrantReportingCodePage).expand_all
    case action
      when :edit;           update_options(pull_edit_cg_reporting_data)
      when :create, :copy;  update_options(pull_new_cg_reporting_data)
    end
  end


  def pull_new_cg_reporting_data
    pulled_cg_data = Hash.new
    on ContractGrantReportingCodePage do |page|
      pulled_cg_data = {
          chart_code:           page.chart_code.value.strip,
          code:                 page.code.value.strip,
          name:                 page.name.value.strip
      }
    end
    pulled_cg_data.merge(pull_new_cg_reporting_code_extended_data)
  end


  def pull_new_cg_reporting_code_extended_data
    Hash.new
  end


  def pull_edit_cg_reporting_data
    pulled_cg_data = Hash.new
    on ContractGrantReportingCodePage do |page|
      pulled_cg_data = {
          chart_code:           page.chart_code_value.text.strip,
          code:                 page.code_value.text.strip,
          name:                 page.name.value.strip
      }
    end
    pulled_cg_data.merge(pull_edit_cg_reporting_code_extended_data)
  end


  def pull_edit_cg_reporting_code_extended_data
    Hash.new
  end

end
