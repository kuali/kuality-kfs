class GeneralErrorCorrectionObject < KFSDataObject

  attr_accessor :organization_document_number, :explanation,
                :from_lines, :to_lines # Each of these should be an array of hashes for the proper settings

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:                       random_alphanums(40, 'AFT'),
        organization_document_number:      random_alphanums(10, 'AFT'),
        explanation:                       'Because I said so!',
        press:                             :save
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

  def post_create
    add_line(:to) unless @from_lines.nil?
    add_line(:from) unless @to_lines.nil?
  end

  def add_line(type)
    case type
    when type == :to
      lines_array = @to_lines
      @to_lines = CollectionsFactory.new(@browser).contains(AccountingLineObject)
      lines_array.each { |line| @to_lines.add(line.merge({target: 'to'})) }
    when type == :from
      lines_array = @from_lines
      @from_lines = CollectionsFactory.new(@browser).contains(AccountingLineObject)
      lines_array.each { |line| @from_lines.add(line.merge({target: 'from'})) }
    end
  end

end