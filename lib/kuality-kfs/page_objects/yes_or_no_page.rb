class YesOrNoPage < BasePage

  action(:yes) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0').click }
  action(:no) { |b| b.frm.button(name: 'methodToCall.processAnswer.button1').click }

end