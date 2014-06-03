class AmendPOReasonPage < BasePage

  element(:reason) { |b| b.frm.textarea(name: 'reason') }
  element(:yes_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0') }
  element(:no_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1') }
  action(:amend) { |b| b.yes_button.click }
  action(:cancel) { |b| b.no_button.click }

end