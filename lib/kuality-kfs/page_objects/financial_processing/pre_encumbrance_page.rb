class PreEncumbrancePage < FinancialProcessingPage

  financial_document_detail
  accounting_lines
  ad_hoc_recipients

  #pre_encumbrance_details
  element(:reversal_date) { |b| b.frm.text_field(name: 'document.reversalDate') }

  #accounting_lines_encumbrance_disencumbrance
  #ENCUMBRANCE
  alias_method :encumbrance_chart_code, :source_chart_code
  alias_method :encumbrance_account_number, :source_account_number
  alias_method :encumbrance_sub_account, :source_sub_account_code
  alias_method :encumbrance_object, :source_object_code
  alias_method :encumbrance_sub_object, :source_sub_object_code
  alias_method :encumbrance_project, :source_project_code
  alias_method :encumbrance_org_ref_id, :source_organization_reference_id
  alias_method :encumbrance_amount, :source_amount
  alias_method :encumbrance_line_description, :source_line_description

  action(:add_encumbrance_line) { |b| b.frm.button(alt: 'Add Encumbrance Accounting Line').click }

  #DISENCUMBRANCE
  alias_method :disencumbrance_chart_code, :target_chart_code
  alias_method :disencumbrance_account_number, :target_account_number
  alias_method :disencumbrance_sub_account, :target_sub_account_code
  alias_method :disencumbrance_object, :target_object_code
  alias_method :disencumbrance_sub_object, :target_sub_object_code
  alias_method :disencumbrance_project, :target_project_code

  #these two alias methods refer to the same data object
  alias_method :disencumbrance_org_ref_id, :target_organization_reference_id
  alias_method :disencumbrance_organization_reference_id, :disencumbrance_org_ref_id

  alias_method :disencumbrance_amount, :target_amount
  alias_method :disencumbrance_reference_number, :target_reference_number

  action(:add_disencumbrance_line) { |b| b.frm.button(alt: 'Add Disencumbrance Accounting Line').click }
end
