class PreEncumbranceObject < KFSDataObject

  attr_accessor   :reversal_date, :chart_code, :account_number, :sub_account, :object, :sub_object,
                  :project, :org_ref_id, :line_description, :amount, :auto_disencumber_type,
                  :start_date, :count, :partial_amount

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
      fill_out page, :description, :reversal_date, :chart_code, :account_number, :sub_account, :object, :sub_object,
                     :project, :org_ref_id, :line_description, :amount, :auto_disencumber_type,
                     :start_date, :count, :partial_amount

      page.add_encumbrance

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
end