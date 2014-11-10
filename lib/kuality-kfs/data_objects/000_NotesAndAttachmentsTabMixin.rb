module NotesAndAttachmentsTabMixin

  # Include this mixin at the bottom of your class definition for best results.
  # Otherwise, the methods it extends may not be defined when the mixin is evaluated.
  # @param [Class] base_class Class that the mixin will be added to
  # @return [Class] Merged Class
  def self.included(base_class)
    base_class.class_eval do

      attr_accessor :notes_and_attachments_tab

      class << self
        def notes_and_attachments_tab_mixin_attributes
          [:notes_and_attachments_tab]
        end
      end

      def default_notes_and_attachments
        {
          notes_and_attachments_tab: collection('NotesAndAttachmentsLineObject')
        }
      end

      # TODO: NotesAndAttachmentsLineObjectCollection#update_from_page!
      # def update_line_objects_from_page!(target=:new)
      #   super_update_line_objects_from_page!
      #   @notes_and_attachments_tab.update_from_page! target
      # end

    end
  end
end