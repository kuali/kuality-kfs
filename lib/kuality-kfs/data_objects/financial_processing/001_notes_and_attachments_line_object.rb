class NotesAndAttachmentsLineObject < DataFactory

  include DateFactory
  include StringFactory

  attr_accessor   :line_number,
                  :note_text, :notification_recipient

  def initialize(browser, opts={})
    @browser = browser

    defaults = { }

    set_options(defaults.merge(opts))
  end

  def create; end

  def edit(opts = {})
    update_options(opts)
  end

  def add(opts = {})
    @note_text = opts[:note_text] unless opts[:note_text].nil?
    on KFSBasePage do |page|
      fill_out page, :note_text
      fill_out_extended_attributes_for_add(opts)
      page.add_note
    end
  end

  def send(opts = {})
    @notification_recipient = opts[:notification_recipient] unless opts[:notification_recipient].nil?
    on KFSBasePage do |page|
      page.notification_recipient(@line_number).fit @notification_recipient
      fill_out_extended_attributes_for_send(opts)
      page.send_note_fyi @line_number
    end
  end

  def attach_file(filename)
    on(KFSBasePage).attach_notes_file.set($file_folder+filename)
  end

  def delete
    on(KFSBasePage).delete_note @line_number
  end

  def extended_create_mappings
    # This needs to return a hash of additional mappings used for create
    Hash.new
  end

  def extended_update_mappings
    # This needs to return a hash of additional mappings used for update
    Hash.new
  end

  def fill_out_extended_attributes_for_add(opts = {})
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

  def fill_out_extended_attributes_for_send(opts = {})
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

end

class NotesAndAttachmentsLineObjectCollection < LineObjectCollection

  contains NotesAndAttachmentsLineObject

end