class GeneralErrorCorrectionPage < FinancialProcessingPage

  financial_document_detail
  accounting_lines

  ad_hoc_recipients

  accounting_lines_for_capitalization
  modify_capital_assets

#create_capital_assets
#  element(:from_reference_origin_code) { |b| b.frm.text_field(name: 'newSourceLine.referenceOriginCode') }
#  element(:from_reference_number) { |b| b.frm.text_field(name: 'newSourceLine.referenceNumber') }
#  element(:to_reference_origin_code) { |b| b.frm.text_field(name: 'newTargetLine.referenceOriginCode') }
#  element(:to_reference_number) { |b| b.frm.text_field(name: 'newTargetLine.referenceNumber') }

end
