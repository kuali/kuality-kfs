class KFSDataObject < DataFactory

  include DateFactory
  include Utilities
  include GlobalConfig

  attr_accessor :document_id, :description, :press,
                :notes_and_attachments_tab

  # Hooks:
  def defaults
    {
      description:               random_alphanums(37, 'AFT'),
      notes_and_attachments_tab: collection('NotesAndAttachmentsLineObject')
    }
  end

  def extended_defaults
    Hash.new
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(extended_defaults).merge(opts))
  end

  def expand_focus_and_clear(page)
    page.expand_all
    page.description.focus
    page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
  end

  def create
    pre_create
    build
    fill_out_extended_attributes
    post_create

    on page_class_for(document_object_of(self.class)) do |page|
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      @document_id = page.document_id
      page.send(@press) unless @press.nil?
    end

  rescue Watir::Exception::UnknownObjectException => uoe
    unless uoe.message.match(/:title=>"Create a new record", :tag_name=>"a"/).nil?
      raise ArgumentError, '"Create New" button was not found on this page. ' <<
                           'Does the current user have the permissions necessary ' <<
                           'for creating a document of this type?' <<
                           "\nOriginal Exception: #{uoe}"
    end

    raise uoe
  end

  def pre_create; end

  def build; end

  def fill_out_extended_attributes(attribute_group=nil); end

  def edit_extended_attributes(attribute_group=nil); end

  def post_create
    @notes_and_attachments_tab = collection('NotesAndAttachmentsLineObject')
  end

  def update_line_objects_from_page!(target=:new)
    update_extended_line_objects_from_page!(target)
  end

  def update_extended_line_objects_from_page!(target=:new); end

  def absorb(target={})
    on KFSBasePage do |b|
      update_options({
        document_id: b.document_id,
        description: b.description.value
      })
    end
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

  def fyi
    on(KFSBasePage).fyi
  end

  def reload
    on(KFSBasePage).reload
  end

  def error_correction
    on(KFSBasePage).error_correction
  end

  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit   @document_id
      search.search
      search.wait_for_search_results
      search.open_doc @document_id
    end
  end

end
