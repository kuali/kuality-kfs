class PayeeLookup < Lookups

  active_radios
  document_header_elements
  alias_method :person_first_name, :first_name
  alias_method :person_last_name, :last_name

  element(:payment_reason_code) { |b| b.frm.select(id: 'paymentReasonCode') }
  element(:vendor_tax_number) { |b| b.frm.text_field(id: 'taxNumber') }
  element(:netid) { |b| b.frm.text_field(id: 'principalName') } # FIXME: This is Cornell-specific
  element(:vendor_name) { |b| b.frm.text_field(id: 'vendorName') }
  element(:employee_id) { |b| b.frm.text_field(id: 'employeeId') }
  element(:vendor_number) { |b| b.frm.text_field(id: 'vendorNumber') }

end