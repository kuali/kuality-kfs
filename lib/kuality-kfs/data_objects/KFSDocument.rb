class KFSDataObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :document_id, :description, :press

  def press_form_button(page)
    case press
      when BasePage::SAVE
        page.save
      when BasePage::SUBMIT
        page.submit
      when BasePage::BLANKET_APPROVE
        page.blanket_approve
      when BasePage::CANCEL
        page.cancel
      when BasePage::CLOSE
        page.close
      when BasePage::RELOAD
        page.reload
      when BasePage::COPY
        page.copy
      when BasePage::APPROVE
        page.approve
      when BasePage::DISAPPROVE
        page.disapprove
      when BasePage::SEND_NOTIFICATION
        page.send_notification
      else
        page.save
    end
  end

end
