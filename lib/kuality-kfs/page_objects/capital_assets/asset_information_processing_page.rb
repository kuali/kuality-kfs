class CapitalAssetInformationProcessingPage < KFSBasePage
  action(:process) { |b| b.frm.link(href: /cabGlLine.do\?methodToCall=process/).click; b.use_new_tab; b.close_parents }

end