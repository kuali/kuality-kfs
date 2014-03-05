class ParameterPage < BasePage

  description_field
  global_buttons

  element(:parameter_value) { |b| b.frm.text_field(id: 'document.newMaintainableObject.value') }

end