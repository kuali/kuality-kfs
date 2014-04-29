class FederalFundedCodeLookupPage < Lookups

  active_radios

  element(:federal_funded_code) { |b| b.frm.text_field(name: 'code') }
  element(:federal_funded_name) { |b| b.frm.text_field(name: 'name') }
  element(:ffc_lookup_frame_text) { |b| b.frm.tbody.text }

end