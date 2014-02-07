class PreEncumbranceObject < KFSDataObject

  DOC_INFO = { label: 'Pre Encumbrance', type_code: 'PE'}

  attr_accessor   :organization_document_number, :explanation,
                  :encumbrance_reversal_date, :encumbrance_chart_code, :encumbrance_account_number,
                  :encumbrance_sub_account, :encumbrance_object, :encumbrance_sub_object,
                  :encumbrance_project, :encumbrance_org_ref_id, :encumbrance_line_description,
                  :encumbrance_amount, :encumbrance_auto_disencumber_type, :encumbrance_start_date,
                  :encumbrance_count, :encumbrance_partial_amount,
                  :disencumbrance_chart_code, :disencumbrance_account_number, :disencumbrance_sub_account,
                  :disencumbrance_object, :disencumbrance_sub_object, :disencumbrance_project,
                  :disencumbrance_org_ref_id, :disencumbrance_line_description, :disencumbrance_amount,
                  :disencumbrance_reference_number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                       random_alphanums(40, 'AFT'),
        press:                             :save
    }

    defaults.merge!({
        encumbrance_chart_code:            'IT', #TODO grab this from config file
        encumbrance_object:                '6100',
        encumbrance_amount:                '0.01'
    }) unless opts[:encumbrance_account_number].nil?

    defaults.merge!({
      disencumbrance_chart_code:           'IT', #TODO grab this from config file
      disencumbrance_object:               '6100',
      disencumbrance_amount:               '0.01'
    }) unless opts[:disencumbrance_account_number].nil?

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).pre_encumbrance
    on PreEncumbrancePage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation

      add_encumbrance unless :encumbrance_account_number.nil?
      add_disencumbrance unless :disencumbrance_account_number.nil?
    end
  end

  def add_encumbrance
    on PreEncumbrancePage do |page|
      fill_out page, :description, :reversal_date, :encumbrance_chart_code, :encumbrance_account_number,
                     :encumbrance_sub_account, :encumbrance_object, :encumbrance_sub_object, :encumbrance_project,
                     :encumbrance_org_ref_id, :encumbrance_line_description, :encumbrance_amount, :encumbrance_auto_disencumber_type,
                     :encumbrance_start_date, :encumbrance_count, :encumbrance_partial_amount
      fill_out_extended_attributes(:encumbrance)
      page.add_encumbrance_line
    end
  end

  def add_disencumbrance
    on PreEncumbrancePage do |page|
      fill_out page, :disencumbrance_chart_code, :disencumbrance_account_number, :disencumbrance_sub_account,
                     :disencumbrance_object, :disencumbrance_sub_object, :disencumbrance_project,
                     :disencumbrance_org_ref_id, :disencumbrance_line_description, :disencumbrance_amount,
                     :disencumbrance_reference_number
      fill_out_extended_attributes(:disencumbrance)
      page.add_disencumbrance_line
    end
  end

  def view
    #@browser.goto "#{$base_url}financialPreEncumbrance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
    #on DocumentSearch do |page|
    #  puts page.url

      @browser.goto "#{$base_url}financialPreEncumbrance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"

      #"https://kfs-ci.kuali.cornell.edu/kfs/financialPreEncumbrance.do?methodToCall=docHandler&docId=4260297&command=displayDocSearchView&backdoorId=hc224#topOfForm"

  end


end #class


