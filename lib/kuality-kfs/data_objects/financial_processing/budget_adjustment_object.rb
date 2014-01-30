class BudgetAdjustmentObject < KFSDataObject

  attr_accessor  :fdd_year, :from_chart_code, :from_account_number,
                 :from_object_code, :from_current_amount, :from_base_amount,
                 :to_chart_code, :to_object_code, :to_current_amount, :to_base_amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT'),
        from_chart_code: 'IT',
        from_account_number: '1258322',
        from_object_code: '4480',
        from_current_amount: '10000'
    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).budget_adjustment

    on BudgetAdjustmentPage do |page|
      @document_id = page.document_id
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      fill_out page, :description, :fdd_year,
               :from_chart_code, :from_account_number, :from_object_code, :from_current_amount, :from_base_amount
      page.add_from_accounting_line unless @from_account_number.nil?

      fill_out page, :to_chart_code, :to_account_number, :to_object_code, :to_current_amount, :to_base_amount
      page.add_to_accounting_line unless @to_account_number.nil?

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

  def viewAsUser(username)
    @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{username}"
  end

  #def view
  #  #TODO:: not sure if this global variable works
  #  @browser.goto "#{$base_url}channelTitle=Budget%20Adjustment&channelUrl=financialBudgetAdjustment.do?methodToCall=docHandler&command=initiate&docTypeName=BA&backdoorId=#{$users.current_user}"
  #end


  def adding_a_from_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    page.from_account_number.fit acct_num
    page.from_object_code.fit obj_code
    page.from_current_amount.fit current_amt
    page.from_line_description.fit line_desc
    page.from_base_amount.fit base_amt

    page.add_from_accounting_line
  end

  def adding_a_to_accounting_line(page, acct_num, obj_code, current_amt, line_desc, base_amt)
    page.to_account_number.fit acct_num
    page.to_object_code.fit obj_code
    page.to_current_amount.fit current_amt
    page.to_line_description.fit line_desc
    page.to_base_amount.fit base_amt

    page.add_to_accounting_line

  end



  def puts_text_fields(page)
    page.frm.text_fields.each { |t| puts 'element(:) { |b| b.frm.text_field(name: \'' + t.name.to_s + '\') }' "\n" }
  end

  def puts_links(page)
    page.frm.links.each { |t| puts 'element(:) { |b| b.frm.link(text: \'' + t.text.to_s + '\') }' "\n" }
  end

  def puts_links_href(page)
    page.frm.links.each { |t| puts 'element(:) { |b| b.frm.link(href: \'' + t.href.to_s + '\') }' "\n" }
  end

# LABELS
   def puts_labels(page)
     page.frm.labels.each { |t| puts 'element(:'+t.text.to_s.downcase.gsub(' ', '_').gsub(':','').gsub('-','_') +') ' "\n"}
   end

# SELECT
    def puts_select(page)
      page.frm.select_lists.each { |t| puts 'element(:) { |b| b.frm.select(name: \''+t.name.to_s+'\') }' }
    end

# CHECKBOXES
    def puts_checkboxes(page)
      page.frm.checkboxes.each { |t| puts 'element(:) { |b| b.frm.checkbox(name: \''+t.name.to_s+'\') }' }
    end

#BUTTONS
    def puts_buttons(page)
      page.frm.buttons.each { |t| puts 'action(:'+ t.title.to_s.downcase.gsub(' ', '_').gsub('-','_') + ') { |b| b.frm.button(title: \'' + t.title.to_s + '\').click }' "\n" }
    end

#RADIO
    def puts_radios(page)
      page.frm.radios.each { |r| puts 'element(:) { |b| b.frm.radio(id: \''+r.id.to_s+'\') }' "\n"}
    end

#WORKS FOR ACCOUNT PAGE
  def puts_text_field_with_name(page)
  page.frm.trs.each do |tr|
      puts 'element(:' + tr.label.text.to_s.downcase.gsub(' ', '_').gsub(':', '').gsub('-','_') + ') ' + '{ |b| b.frm.text_field(name: ' + tr.text_field.name.to_s + ') }' + "\n"
    end
  end



end #class
