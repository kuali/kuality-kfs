class KFSDataObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :document_id, :description, :press,
                :from_lines, :to_lines


  # Hooks:
  def create
    pre_create
    build
    fill_out_extended_attributes
    post_create

    page_klass = Kernel.const_get(self.class.to_s.gsub(/(.*)Object$/,'\1Page'))
    on page_klass do |page|
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      @document_id = page.document_id
      page.send(@press) unless @press.nil?
    end
  end

  def pre_create
  end

  def build
  end

  def fill_out_extended_attributes(attribute_group=nil)
  end

  def post_create
  end

  def save
    on(KFSBasePage).save
  end

  def submit
    on(KFSBasePage).submit
  end

  def blanket_approve
    on(KFSBasePage).blanket_approve
  end

  def copy
    on(KFSBasePage).copy
  end

  def copy_current_document
    on(KFSBasePage).copy_current_document
  end

  def cancel
    on(KFSBasePage).cancel
  end

  def approve
    on(KFSBasePage).approve
  end

  def reload
    on(KFSBasePage).reload
  end

  def error_correction
    on(KFSBasePage).error_correction
  end

  #def view #should be overridden for transactional documents
  #  @browser.goto "#{$base_url}kr/maintenance.do?methodToCall=docHandler&docId=#{@document_id}&command=displayDocSearchView"
  #end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      if search.frm.divs(id: 'lookup')[0].parent.text.include?('No values match this search.')
        # Double-check, for timing issues.
        sleep 10
        search.search
      end
      search.open_doc @document_id
    end
  end

  def self.to_var_name
    snake_case self.class.to_s.partition(/Object$/)[0]
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

end
