class RecallPage < BasePage

  element(:reason) { |b| b.frm.textarea(name: 'reason') }
  element(:recall_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0') }
  element(:recall_and_cancel_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1') }
  action(:recall) { |b| b.recall_button.click }
  action(:recall_and_cancel) { |b| b.recall_and_cancel_button.click }

end