class GeneralErrorCorrectionObject < KFSDataObject

  attr_accessor   :from_chart_code, :from_account_number, :from_sub_account, :from_object, :from_sub_object,
                  :from_project, :from_org_ref_id, :from_reference_origin_code, :from_reference_number,
                  :from_line_description, :from_amount,
                  :to_chart_code, :to_account_number, :to_sub_account, :to_object, :to_sub_object, :to_project,
                  :to_org_ref_id, :to_reference_origin_code, :to_reference_number, :to_line_description, :to_amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                       random_alphanums(40, 'AFT'),
        organization_document_number:      random_alphanums(10, 'AFT'),
        explanation:                       'Because I said so!',
        press:                             :save
    }

    defaults.merge!({
      from_chart_code:            '',
      from_account_number:        '',
      from_sub_account:           '',
      from_object:                '',
      from_sub_object:            '',
      from_project:               '',
      from_org_ref_id:            '',
      from_reference_origin_code: '',
      from_reference_number:      '',
      from_line_description:      '',
      from_amount:                ''
    }) unless @from_account_number.nil?

    defaults.merge!({
      to_chart_code:              '',
      to_account_number:          '',
      to_sub_account:             '',
      to_object:                  '',
      to_sub_object:              '',
      to_project:                 '',
      to_org_ref_id:              '',
      to_reference_origin_code:   '',
      to_reference_number:        '',
      to_line_description:        '',
      to_amount:                  ''
    }) unless @to_account_number.nil?

    set_options(defaults.merge(opts))
  end

  def create
    pre_create

    visit(MainPage).general_error_correction
    on GeneralErrorCorrectionPage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
      fill_out_extended_attributes

      add_from_line unless @from_account_number.nil?
      add_to_line unless @to_account_number.nil?

      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      page.send(@press) unless @press.nil?
    end

    post_create
  end

  def add_from_line
    on GeneralErrorCorrectionPage do |page|
      fill_out page, :from_chart_code, :from_account_number, :from_sub_account, :from_object,
                     :from_sub_object, :from_project, :from_org_ref_id, :from_reference_origin_code,
                     :from_reference_number, :from_line_description, :from_amount
      fill_out_extended_attributes(:from_line)
      page.add_from_line
    end
  end

  def add_to_line
    on GeneralErrorCorrectionPage do |page|
      fill_out page, :to_chart_code, :to_account_number, :to_sub_account, :to_object,
                     :to_sub_object, :to_project, :to_org_ref_id, :to_reference_origin_code,
                     :to_reference_number, :to_line_description, :to_amount
      fill_out_extended_attributes(:to_line)
      page.add_to_line
    end
  end

  def save
    on(GeneralErrorCorrectionPage).save
  end

  def submit
    on(GeneralErrorCorrectionPage).submit
  end

  def blanket_approve
    on(GeneralErrorCorrectionPage).blanket_approve
  end

  def view
    # TODO: GeneralErrorCorrectionObject#view
  end

  def copy
    on(GeneralErrorCorrectionPage).copy
  end

end