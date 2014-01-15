class PreEncumbranceObject < KFSDataObject

  attr_accessor   :encumbrance_reversal_date, :encumbrance_chart_code, :encumbrance_account_number, :encumbrance_sub_account, :encumbrance_object, :encumbrance_sub_object,
                  :encumbrance_project, :encumbrance_org_ref_id, :encumbrance_line_description, :encumbrance_amount, :encumbrance_auto_disencumber_type,
                  :encumbrance_start_date, :encumbrance_count, :encumbrance_partial_amount,
                  :disencumbrance_chart_code, :disencumbrance_account_number, :disencumbrance_sub_account, :disencumbrance_object, :disencumbrance_sub_object,
                  :disencumbrance_project, :disencumbrance_org_ref_id, :disencumbrance_line_description, :disencumbrance_amount, :disencumbrance_reference_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:          random_alphanums(40, 'AFT'),
        chart_code:           'IT', #TODO grab this from config file
        account_number:       random_alphanums(7),
        object:               '6100',
        amount:               '0.01'
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(MainPage).pre_encumbrance
    on PreEncumbrancePage do |page|
      @document_id = page.document_id
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...


      #fill_out page, :description, :encumbrance_reversal_date, :encumbrance_chart_code, :encumbrance_account_number, :encumbrance_sub_account, :encumbrance_object, :encumbrance_sub_object,
      #               :encumbrance_project, :encumbrance_org_ref_id, :encumbrance_line_description, :encumbrance_amount, :encumbrance_auto_disencumber_type,
      #               :encumbrance_start_date, :encumbrance_count, :encumbrance_partial_amount
      #
      #page.add_encumbrance

      if !:encumbrance_account_number.nil?
        add_encumbrance :encumbrance_reversal_date, :encumbrance_chart_code, :encumbrance_account_number, :encumbrance_sub_account, :encumbrance_object, :encumbrance_sub_object,
                        :encumbrance_project, :encumbrance_org_ref_id, :encumbrance_line_description, :encumbrance_amount, :encumbrance_auto_disencumber_type,
                        :encumbrance_start_date, :encumbrance_count, :encumbrance_partial_amount
      end


      if !:disencumbrance_reference_number.nil?
        add_disencumbrance :disencumbrance_chart_code, :disencumbrance_account_number, :disencumbrance_sub_account, :disencumbrance_object, :disencumbrance_sub_object,
                           :disencumbrance_project, :disencumbrance_org_ref_id, :disencumbrance_line_description, :disencumbrance_amount, :disencumbrance_reference_number
      end

      press_form_button page
    end
  end

  def save
    on(PreEncumbrancePage).save
  end

  def submit
    on(PreEncumbrancePage).submit
  end

  def blanket_approve
    on(PreEncumbrancePage).blanket_approve
  end

  def view
    # TODO: preencumbrance_object#view
  end

  def add_encumbrance(*opts)
    on PreEncumbrancePage do |page|
      fill_out page, *opts
      page.add_encumbrance
    end
  end

  def add_disencumbrance(*opts)
    on PreEncumbrancePage do |page|
      fill_out page, *opts
      page.add_disencumbrance
    end
  end
end
