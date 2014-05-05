class ParameterLookup < Lookups

  element(:namespace_code) { |b| b.frm.select(id: 'namespaceCode') }
  element(:component) { |b| b.frm.text_field(id: 'component.name') }
  element(:application_id) { |b| b.frm.text_field(id: 'applicationId') }
  element(:parameter_name) { |b| b.frm.text_field(id: 'name') }
  element(:parameter_value) { |b| b.frm.text_field(id: 'value') }
  element(:parameter_type) { |b| b.frm.select(id: 'parameterTypeCode') }

end