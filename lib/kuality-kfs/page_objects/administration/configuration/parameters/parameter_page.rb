class ParameterPage < KFSBasePage

  # Create version
  element(:namespace_code) { |b| b.frm.select(id: 'document.newMaintainableObject.namespaceCode') }
  element(:component) { |b| b.frm.text_field(id: 'document.newMaintainableObject.componentCode') }
  element(:application_id) { |b| b.frm.text_field(id: 'document.newMaintainableObject.applicationId') }
  element(:parameter_name) { |b| b.frm.text_field(id: 'document.newMaintainableObject.name') }
  element(:parameter_value) { |b| b.frm.text_field(id: 'document.newMaintainableObject.value') }
  element(:parameter_description) { |b| b.frm.text_field(id: 'document.newMaintainableObject.description') }
  element(:parameter_type_code) { |b| b.frm.select(id: 'document.newMaintainableObject.parameterTypeCode') }
  element(:parameter_constraint_code) { |b| b.frm.radios(name: 'document.newMaintainableObject.evaluationOperatorCode') }
  element(:parameter_constraint_code_allowed) { |b| b.frm.radio(id: 'document.newMaintainableObject.evaluationOperatorCodeAllowed') }
  element(:parameter_constraint_code_denied) { |b| b.frm.radio(id: 'document.newMaintainableObject.evaluationOperatorCodeDenied') }

  # Update version
  element(:old_namespace_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.namespaceCode.div').text.strip }
  element(:old_component) { |b| b.frm.span(id: 'document.oldMaintainableObject.componentCode.div').text.strip }
  element(:old_application_id) { |b| b.frm.span(id: 'document.oldMaintainableObject.applicationId.div').text.strip }
  element(:old_parameter_name) { |b| b.frm.span(id: 'document.oldMaintainableObject.name.div').text.strip }
  element(:old_parameter_value) { |b| b.frm.span(id: 'document.oldMaintainableObject.value.div').text.strip }
  element(:old_parameter_description) { |b| b.frm.span(id: 'document.oldMaintainableObject.description.div').text.strip }
  element(:old_parameter_type_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.parameterTypeCode.div').text.strip }
  element(:old_parameter_constraint_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.evaluationOperatorCode.div').text.strip }

  element(:new_namespace_code) { |b| b.frm.span(id: 'document.newMaintainableObject.namespaceCode.div').text.strip }
  element(:new_component) { |b| b.frm.span(id: 'document.newMaintainableObject.componentCode.div').text.strip }
  element(:new_application_id) { |b| b.frm.span(id: 'document.newMaintainableObject.applicationId.div').text.strip }
  element(:new_parameter_name) { |b| b.frm.span(id: 'document.newMaintainableObject.name.div').text.strip }
  alias_method :new_parameter_value, :parameter_value
  alias_method :new_parameter_description, :parameter_description
  alias_method :new_parameter_type_code, :parameter_type_code
  alias_method :new_parameter_constraint_code, :parameter_constraint_code
  alias_method :new_parameter_constraint_code_allowed, :parameter_constraint_code_allowed
  alias_method :new_parameter_constraint_code_denied, :parameter_constraint_code_denied

end