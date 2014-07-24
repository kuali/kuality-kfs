class KFSBasePage < BasePage

  expected_element :doc_title_element, 600000

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