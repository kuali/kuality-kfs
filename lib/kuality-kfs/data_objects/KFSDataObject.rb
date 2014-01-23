class KFSDataObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :document_id, :description, :press

  def create
    pre_create
    build
    fill_out_extended_attributes
    post_create

    $current_page.alert.ok if $current_page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
    @document_id = $current_page.document_id
    $current_page.send(@press) unless @press.nil?
  end

  # Hooks:
  def pre_create
  end

  def build
  end

  def fill_out_extended_attributes(attribute_group=nil)
  end

  def post_create
  end

end
