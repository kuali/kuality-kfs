class KFSDataObject < DataFactory

  include DateFactory
  include Utilities
  include GlobalConfig

  attr_accessor :document_id, :description, :press,
                :notes_and_attachments_tab


  # Hooks:
  def create
    pre_create
    build
    fill_out_extended_attributes
    post_create

    on page_class_for(self) do |page|
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      @document_id = page.document_id
      page.send(@press) unless @press.nil?
    end
  end

  def pre_create; end

  def build; end

  def fill_out_required_attributes
    on page_class_for(self) do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description
    end
  end

  def fill_out_optional_attributes; end

  def fill_out_extended_attributes(attribute_group=nil); end

  def post_create
    @notes_and_attachments_tab = collection('NotesAndAttachmentsLineObject')
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
      search.document_id.fit @document_id
      search.search
      search.wait_for_search_results
      search.open_doc @document_id
    end
  end

end
