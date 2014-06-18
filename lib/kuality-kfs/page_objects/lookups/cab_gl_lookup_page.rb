class CabGlLookupPage < Lookups
  element(:account_number) { |b| b.frm.text_field(id: 'accountNumber') }

end
