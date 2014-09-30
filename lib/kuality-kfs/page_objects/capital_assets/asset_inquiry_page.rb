class AssetInquiryPage < KFSBasePage

  action(:toggle_payment) { |b| b.frm.button(id: 'tab-Payments-imageToggle').click }
  value(:asset_number) { |i=0, b| b.frm.span(id: "assetPayments[#{i}].capitalAssetNumber.div").text.strip }
  value(:asset_account_number) { |i=0, b| b.frm.span(id: "assetPayments[#{i}].accountNumber.div").text.strip }
  value(:asset_object_code) { |i=0, b| b.frm.span(id: "assetPayments[#{i}].financialObjectCode.div").text.strip }
  value(:asset_amount) { |i=0, b| b.frm.span(id: "assetPayments[#{i}].accountChargeAmount.div").text.strip }
  value(:asset_chart) { |i=0, b| b.frm.span(id: "assetPayments[#{i}].chartOfAccountsCode.div").text.strip }

end