class ContractGrantReportingCodePage < KFSBasePage

  #create or copy data on the page, editable data on the page
  element(:chart_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.chartOfAccountsCode') }
  element(:code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.code') }

  #create or copy or edit data on the page, editable data on the page
  element(:name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.name') }

  #edit data on the page, this is view only data
  value(:chart_code_value) { |b| b.frm.span(id: "document.newMaintainableObject.chartOfAccountsCode.div") }
  value(:code_value) { |b| b.frm.span(id: "document.newMaintainableObject.code.div") }

end