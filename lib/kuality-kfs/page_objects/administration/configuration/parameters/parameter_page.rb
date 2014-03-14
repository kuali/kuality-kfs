class ParameterPage < KFSBasePage

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

end