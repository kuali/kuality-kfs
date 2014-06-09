class NotesAndAttachmentsLineObject < DataFactory

  include DateFactory
  include StringFactory

  attr_accessor   :line_number,
                  :note_text, :notification_recipient, :file,
                  :immediate_add, :immediate_attach, :immediate_fyi

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
                 immediate_add:    true,
                 immediate_attach: true,
                 immediate_fyi:    true
               }

    set_options(defaults.merge(opts))
  end

  def create
    on KFSBasePage do |page|
      fill_out page, :note_text
      fill_out_extended_attributes
      attach_file @file unless @file.nil?
      page.add_note unless @immediate_add.false? || @immediate_add.nil?
    end
    send_fyi unless @notification_recipient.nil?
  end

  def edit(opts = {})
    @note_text = opts[:note_text] unless opts[:note_text].nil?
    on KFSBasePage do |page|
      fill_out page, :note_text
      update_extended_attributes(opts)
      attach_file opts[:file] unless opts[:file].nil? || opts[:immediate_attach].false? || opts[:immediate_attach].nil?
      page.add_note unless opts[:immediate_add].false? || opts[:immediate_add].nil?
    end
    send_fyi(opts) unless opts[:notification_recipient].nil? || opts[:immediate_fyi].false? || opts[:immediate_fyi].nil?
    update_options(opts)
  end
  alias_method :update, :edit

  def send_fyi(opts = {})
    @notification_recipient = opts[:notification_recipient] unless opts[:notification_recipient].nil?
    on KFSBasePage do |page|
      page.notification_recipient(@line_number).fit @notification_recipient
      fill_out_extended_attributes_for_send(opts)
      page.send_note_fyi @line_number
    end
  end

  def attach_file(filename)
    canonical_path = File.expand_path($file_folder+filename)
    on(KFSBasePage).attach_notes_file.set(canonical_path)
    on(KFSBasePage).attach_notes_file.value.include?(filename).true?.should
  end

  def download_file
    on(KFSBasePage).download_file @line_number
  end

  def delete
    on(KFSBasePage).delete_note @line_number
  end

  def fill_out_extended_attributes
    # Override this method if you have site-specific extended attributes.
  end

  def update_extended_attributes(opts = {})
    # Override this method if you have site-specific extended attributes.
  end
  alias_method :edit_extended_attributes, :update_extended_attributes

  def fill_out_extended_attributes_for_send(opts = {})
    # Override this method if you have site-specific extended attributes.
    # You'll probably need to use the provided @target value to generate the
    # proper symbols.
  end

end

class NotesAndAttachmentsLineObjectCollection < LineObjectCollection

  contains NotesAndAttachmentsLineObject

end