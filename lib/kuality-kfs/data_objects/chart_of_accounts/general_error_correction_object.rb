class GeneralErrorCorrectionObject < KFSDataObject

  attr_accessor :organization_document_number, :explanation,
                :from_lines, :to_lines

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                     random_alphanums(40, 'AFT'),
        organization_document_number:    random_alphanums(10, 'AFT'),
        explanation:                     'Because I said so!',
        from_lines:                      collection('AccountingLineObject'),
        to_lines:                        collection('AccountingLineObject'),
        press:                           nil
    }

    set_options(defaults.merge(opts))
  end

  def build
    visit(MainPage).general_error_correction
    on GeneralErrorCorrectionPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      search.open_doc @document_id
    end
  end

  def add_line(type, al)
    case type
      when :to
        @to_lines.add(al.merge({target: 'to'}))
      when :from
        @from_lines.add(al.merge({target: 'from'}))
    end
  end

  def add_to_line(al)
    add_line(:to, al)
  end

  def add_from_line(al)
    add_line(:from, al)
  end

  def to_var_name
    'ged'
  end

end