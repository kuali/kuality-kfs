class PurapTransactionPage < KFSBasePage

  element(:select) { |b| b.checkbox(name: 'purApDoc[0].purchasingAccountsPayableItemAsset[0].selectedValue') }
  element(:split_qty) { |b| b.text_field(name: 'purApDoc[0].purchasingAccountsPayableItemAsset[0].splitQty') }

  action(:view_doc) { |b| b.frm.link(href: /cabPurApLine.do/).click }

end