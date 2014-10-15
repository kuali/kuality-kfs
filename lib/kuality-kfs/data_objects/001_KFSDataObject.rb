class KFSDataObject < DataFactory

  include DateFactory
  include Utilities
  include GlobalConfig

  attr_accessor :document_id, :description,
                :initiator,
                :press #, :notes_and_attachments_tab

  # Hooks:
  class << self
    # Attributes that are required for a successful save/submit.
    # @return [Array] List of Symbols for attributes that are required
    def required_attributes
      [:description]
    end

    # Attributes that don't copy over to a new document's fields during a copy.
    # @return [Array] List of Symbols for attributes that aren't copied to the new side of a copy
    def uncopied_attributes
      [:description, :initiator, :document_id]
    end

    # Attributes that always appear to be read-only on the page and thus would not
    # be good candidates for #fill_out or #edit_fields
    # @return [Array] List of Symbols for attributes that are immutable on the page
    def read_only_attributes
      [:initiator, :document_id, :press]
    end
  end

  # Overloaded equality operator. Useful for equality while copying a document, this compares based
  # on attribute values that should be carried over during a copy.
  def ==(other_acct)
    if other_acct.is_a? self.class
      self.class
          .attributes
          .reject{ |a| self.class.uncopied_attributes.include?(a) }
          .all?{ |attr| self.instance_variable_get("@#{attr}") == other_acct.instance_variable_get("@#{attr}") }
    else
      false
    end
  end

  # Overloaded equality operator. Useful for strict equality, this compares based on all attribute values.
  def eql?(other_acct)
    if other_acct.is_a? self.class
      self.class
          .attributes
          .all?{ |attr| self.instance_variable_get("@#{attr}") == other_acct.instance_variable_get("@#{attr}") }
    else
      false
    end
  end

  def defaults
    {
      description:               random_alphanums(37, 'AFT') #,
      #notes_and_attachments_tab: collection('NotesAndAttachmentsLineObject')
    }.merge(default_notes_and_attachments)
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
      page.alert.ok if page.alert.present? # Because, y'know, sometimes it doesn't actually come up...
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

  def update(opts={})
    on(KFSBasePage) { |p| edit_fields opts, p, :description }
    update_options({description: opts[:description]})
  end
  alias_method :edit, :update

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

  def absorb!(target={})
    on KFSBasePage do |b|
      description =  case target
                       when :new
                         b.description.value
                       when :old
                         b.readonly_description
                     end
      update_options({
        document_id: b.document_id,
        description: description,
        initiator:   b.initiator
      })
    end
  end

  def save
    update_data_from_header
    on(KFSBasePage).save
  end

  def submit
    update_data_from_header
    on(KFSBasePage).submit
  end

  def blanket_approve
    update_data_from_header
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
    sleep 3
    on DocumentSearch do |search|
      search.close_parents
      search.document_type.fit ''
      search.document_id.fit   @document_id
      search.search
      search.wait_for_search_results
      search.open_doc @document_id
    end
  end

  # # @param [Hash][Array] data_item Single array element from a WebService call for the data object in question.
  # def absorb_webservice_item!(data_item); end

  class << self
    # Used in method absorb_webservice_item! or can be called standalone
    # @param [Hash][Array] data_item Single array element from a WebService call for the data object in question.
    # @return [Hash] A hash of the object's data attributes and the values provided in the data_item.
    def webservice_item_to_hash(data_item); end

    def extended_webservice_item_to_hash(data_item); end
  end

  # @param [Hash][Array] data_item Single array element from a WebService call for the data object in question.
  def absorb_webservice_item!(data_item)
    data_hash = self.class.webservice_item_to_hash(data_item)
    update_options(data_hash)
  end

  private

  # Grabs values, lest we haven't before (e.g. we used #make previously instead of #create)
  def update_data_from_header
    on KFSBasePage do |page|
      @document_id = page.document_id
      @initiator   = page.initiator
    end
  end

  include NotesAndAttachmentsTabMixin
end
