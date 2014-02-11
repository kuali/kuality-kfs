class YesOrNoPage < BasePage

  element(:yes_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0') }
  element(:no_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1') }
  action(:yes) { |b| b.yes_button.click }
  action(:no) { |b| b.no_button.click }

end