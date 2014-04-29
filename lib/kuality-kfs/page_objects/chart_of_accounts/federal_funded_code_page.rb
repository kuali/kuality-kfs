class FederalFundedCodePage < KFSBasePage

  # document_overview
  # notes_and_attachments
  # ad_hoc_recipients
  # route_log

  element(:federal_funded_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.code') }
  element(:federal_funded_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.name') }

  #COPY
  #may need to remove spaces at end for these returned '1  ' and 'TEST 234567  '
  value(:org_federal_funded_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.code.div').text}
  value(:org_federal_funded_name) { |b| b.frm.span(id: 'document.oldMaintainableObject.name.div').text}

  #EDIT
  element(:active_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

end

class FederalFundedCodeInquiryPage < FederalFundedCodePage

  value(:federal_funded_code_value) { |b| b.span(id: 'code.div').text.strip }
  value(:federal_funded_name_value) { |b| b.span(id: 'name.div').text.strip }
  value(:active_indicator_value)    { |b| b.span(id: 'active.div').text.strip }

end