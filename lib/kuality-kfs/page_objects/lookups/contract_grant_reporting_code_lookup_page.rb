class ContractGrantsReportingCodeLookupPage < Lookups

  element(:chart_code) { |b| b.frm.text_field(id: 'chartOfAccountsCode') }
  element(:code) { |b| b.frm.text_field(id: 'code') }
  element(:name) { |b| b.frm.text_field(id: 'name') }

end