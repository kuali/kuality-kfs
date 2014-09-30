class GeneralLedgerProcessingPage < KFSBasePage
  action(:create_asset) { |b| b.frm.button(name: "methodToCall.submitAssetGlobal").click }
  action(:apply_payment) { |b| b.frm.button(name: "methodToCall.submitPaymentGlobal").click }

end