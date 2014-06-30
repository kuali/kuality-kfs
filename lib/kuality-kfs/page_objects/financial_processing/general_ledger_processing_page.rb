class GeneralLedgerProcessingPage < KFSBasePage
  action(:create_asset) { |b| b.frm.button(name: "methodToCall.submitAssetGlobal").click }

end