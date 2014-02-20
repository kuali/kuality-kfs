class PayeeLookup < Lookups

  active_radios

  alias_method :person_first_name, :first_name
  alias_method :person_last_name, :last_name

  element(:payment_reason_code) { |b| b.frm.select(id: 'paymentReasonCode') }
  element(:vendor_tax_number) { |b| b.frm.select(id: 'taxNumber') }
  element(:netid) { |b| b.frm.select(id: 'principalName') } # FIXME: This is Cornell-specific
  element(:vendor_name) { |b| b.frm.select(id: 'vendorName') }
  element(:employee_id) { |b| b.frm.select(id: 'employeeId') }
  element(:vendor_number) { |b| b.frm.select(id: 'vendorNumber') }

end