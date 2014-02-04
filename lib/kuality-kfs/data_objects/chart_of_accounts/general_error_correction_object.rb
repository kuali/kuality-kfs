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
    add_line(:to) unless @from_lines.empty?
    add_line(:from) unless @to_lines.empty?
  end

  def add_line(type)
    case type
    when :to
      puts @to_lines
      @to_lines = @to_lines.is_a?(Array) ? @to_lines : [@to_lines]
      lines_array = collection('AccountingLineObject')
      @to_lines.each { |line| lines_array.add line.merge({target: 'to'})}
      #@to_lines = @to_lines.is_a?(Array) ? @to_lines : [@to_lines]
      #lines_array = CollectionsFactory.new(@browser)
      #lines_array.contains(AccountingLineObject)
      #@to_lines.each { |line| puts "Adding line for #{line}"; lines_array.add(line.merge({target: 'to'})) }
    when :from
      puts @from_lines
      @from_lines = @from_lines.is_a?(Array) ? @from_lines : [@from_lines]
      lines_array = collection('AccountingLineObject')
      @from_lines.each { |line| lines_array.add line.merge({target: 'from'})}
      #@from_lines = @from_lines.is_a?(Array) ? @from_lines : [@from_lines]
      #lines_array = CollectionsFactory.new(@browser)
      #lines_array.contains(AccountingLineObject)
      #@from_lines.each { |line| puts "Adding line for #{line}"; lines_array.add(line.merge({target: 'from'})) }
    end
  end

end