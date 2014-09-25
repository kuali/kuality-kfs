class KFSBasePage < BasePage

  #expected_element :doc_title_element, 600000
  # In the long run, we should be able to uncomment the above line because anytime we 
  # try to go to a KFSBasePage this element should exist. Unfortunately, we can't for now
  # because if you use on(KFSBasePage), execution will hang until the expected_element 
  # materializes (or it'll error out). That's to be expected, but we have some checks
  # that try to use on(KFSBasePage) to determine whether we are actually *on* a given page
  # (see AssetManualPaymentObject#build). In the case that we aren't, these checks don't
  # work as intended. - KO

  document_header_elements
  description_field
  global_buttons
  tiny_buttons
  tab_buttons
  error_messages
  route_log
  notes_and_attachments
  general_ledger_pending_entries

end
