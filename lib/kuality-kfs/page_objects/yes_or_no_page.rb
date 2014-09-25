class YesOrNoPage < BasePage

  element(:yes_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0') }
  element(:no_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1') }
  action(:yes) { |b| b.yes_button.click }
  action(:no) { |b| b.no_button.click }

  action(:yes_if_possible) { |b| if b.yes_button.exists? && b.yes_button.visible?; b.yes end }
  action(:no_if_possible) { |b| if b.no_button.exists? && b.no_button.visible?; b.no end }

end