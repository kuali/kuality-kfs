class AuxiliaryVoucherObject < KFSDataObject

  attr_accessor :debit,
                :from_chart_code, :from_account_number,
                :from_object_code, :from_current_amount, :from_base_amount, :from_line_description,

                :credit_chart_code, :credit_account_number, :credit_object_code,  :credit,
                :credit_line_description,

                :from_file_name, :to_file_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = { description:    random_alphanums(20, 'AFT Aux Vo '),

                 debit: '100', from_chart_code: 'IT', from_account_number: '1258322', from_object_code: '4480',
                 credit: '100', credit_chart_code: 'IT', credit_account_number: 'H803800', credit_object_code: '6690'


    }
    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).budget_adjustment

    on AuxiliaryVoucherPage do |page|

      @document_id = page.document_id
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...

      unless @debit.nil?
        fill_out page, :description, #:fdd_year,

                 :from_chart_code, :from_account_number, :from_object_code, :debit, :from_line_description
        page.add_from_accounting_line
      end

      unless @credit.nil?
              fill_out page, :description
              page.from_chart_code.fit @credit_chart_code
              page.from_account_number.fit @credit_account_number
              page.from_object_code.fit @credit_object_code
              page.credit.fit @credit
              page.from_line_description.fit @credit_line_description
              page.add_from_accounting_line
      end

      fill_out_extended_attributes

      page.send(@press) unless @press.nil?
    end
  end

end #class

