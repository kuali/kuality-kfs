class KFSDataObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :document_id, :description, :press

  # Hooks:
  def pre_create
  end

  def post_create
  end

  def fill_out_extended_attributes(attribute_group=nil)
  end



end
