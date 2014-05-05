class MaintenanceObject < DataFactory

  include DateFactory
  include StringFactory
  include GlobalConfig

  attr_accessor :document_id, :description, :press

  # Hooks:
  def create(opts={})
    pre_create
    build
    fill_out_extended_attributes(opts)
    post_create

    finish
  end

  def edit(opts={})
    pre_edit
    update(opts)
    update_extended_attributes(opts)
    post_edit

    update_options(opts)
    finish
  end

  def pre_create
  end

  def build
  end

  def fill_out_extended_attributes(attribute_group=nil)
  end

  def post_create
  end

  def pre_edit
  end

  def update(opts={})
  end

  def update_extended_attributes(attribute_group=nil)
  end

  def post_edit
  end

  # Utilities
  def finish
    page_klass = Kernel.const_get(self.class.to_s.gsub(/(.*)Object$/,'\1Page'))
    on page_klass do |page|
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      @document_id = page.document_id
      page.send(@press) unless @press.nil?
    end
  end

  def prep_page
    on KFSBasePage do |page|
      page.description.focus
      page.expand_all
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
    end
  end

  # Button Shortcuts:
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

  # Lookups:
  def view
    visit(MainPage).doc_search
    on DocumentSearch do |search|
      search.document_type.fit ''
      search.document_id.fit @document_id
      search.search
      if search.no_result_table_returned?
        # Double-check, for timing issues.
        sleep 10
        search.search
      end
      search.open_doc @document_id
    end
  end

end
