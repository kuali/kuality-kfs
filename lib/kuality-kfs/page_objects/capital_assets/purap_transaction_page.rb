class PurapTransactionPage < KFSBasePage

  element(:select) { |b| b.checkbox(name: 'purApDoc[0].purchasingAccountsPayableItemAsset[0].selectedValue') }
  #element(:split_qty) { |b| b.text_field(name: 'purApDoc[0].purchasingAccountsPayableItemAsset[0].splitQty') }

  action(:view_doc) { |b| b.frm.link(href: /cabPurApLine.do/).click }

  # code from Todd
  #not sure how to get second number(ln) to change maybe if you split but put in just in case
  element(:line_item_checkbox) { |l=0, ln=0,b| b.checkbox(name: "purApDoc[#{l}].purchasingAccountsPayableItemAsset[#{ln}].selectedValue") }
  element(:split_qty) { |l=0, ln=0, b| b.text_field(name: "purApDoc[#{l}].purchasingAccountsPayableItemAsset[#{ln}].splitQty") }
  element(:line_item_description) { |l=0, ln=0,b| b.text_field(name: "purApDoc[#{l}].purchasingAccountsPayableItemAsset[#{ln}].accountsPayableLineItemDescription") }

  element(:merge_qty) { |b| b.text_field(name: 'mergeQty') }
  element(:merge_desc) { |b| b.text_field(name: 'mergeDesc') }


  action(:split) { |l=0,ln=0, b| b.button(name: "methodToCall.split.doc#{l}.line#{ln}").click }
  action(:allocate) { |l=0,ln=0, b| b.button(name: "methodToCall.allocate.doc#{l}.line#{ln}").click }
  action(:create_asset)  { |l=0,ln=0, b| b.button(name: "methodToCall.createAsset.doc#{l}.line#{ln}").click }
  action(:apply_payment) { |l=0, ln=0, b| b.button(name: "methodToCall.applyPayment.doc#{l}.line#{ln}").click }

  action(:merge) { |b| b.button(title: 'merge').click }

  action(:open_submitted_line_items) { |b| b.button(title: 'open Submitted Line Items').click }
end