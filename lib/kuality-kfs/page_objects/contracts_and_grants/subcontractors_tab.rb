class SubcontractorsTab < PageFactory

  include Utilities
  include GlobalConfig

  element(:new_subcontractor_number) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)Subcontractors.subcontractorNumber/) }
  element(:new_subcontractor_description) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)Subcontractors.(proposal|award)SubcontractorDescription/) }
  element(:new_subcontractor_amount) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)Subcontractors.(proposal|award)SubcontractorAmount/) }
  element(:new_subcontractor_active_indicator) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(proposal|award)Subcontractors.active/) }
  action(:add_new_subcontractor) { |b| b.frm.button(id: /^methodToCall\.addLine\.(proposal|award)Subcontractors/).click }
  action(:delete_subcontractor) { |i=0, b| b.frm.button(id: /methodToCall.deleteLine.(proposal|award)Subcontractors.\(!!.line#{i}/).click }
  element(:subcontractor_tab) { |b| b.frm.div(id: 'tab-Subcontractors-div') }
  value(:current_subcontractor_count) { |b| b.subcontractor_tab.spans(class: 'left', text: /Subcontractor [(]/m).length }
  action(:update_subcontractor_number) { | i=0, b|
    b.subcontractor_tab.span(id: /document.newMaintainableObject.(proposal|award)Subcontractors\[#{i}\].subcontractorNumber.div/)
  }
  action(:update_subcontractor_description) { |i=0, b| b.subcontractor_tab.text_field(id: /document.newMaintainableObject.(proposal|award)Subcontractors\[#{i}\].(proposal|award)SubcontractorDescription/) }
  action(:update_subcontractor_amount) { |i=0, b| b.subcontractor_tab.text_field(id: /document.newMaintainableObject.(proposal|award)Subcontractors\[#{i}\].(proposal|award)SubcontractorAmount/) }
  action(:update_subcontractor_active_indicator) { |i=0, b| b.subcontractor_tab.text_field(id: /document.newMaintainableObject.(proposal|award)Subcontractors\[#{i}\].active/) }
  value(:old_subcontractor_number) { |i=0, b| b.subcontractor_tab.span(id: /document.oldMaintainableObject.(proposal|award)Subcontractors\[#{i}\].subcontractorNumber.div/).text.strip }
  value(:old_subcontractor_description) { |i=0, b| b.subcontractor_tab.span(id: /document.oldMaintainableObject.(proposal|award)Subcontractors\[#{i}\].(proposal|award)SubcontractorDescription.div/).text.strip }
  value(:old_subcontractor_amount) { |i=0, b| b.subcontractor_tab.span(id: /document.oldMaintainableObject.(proposal|award)Subcontractors\[#{i}\].(proposal|award)SubcontractorAmount.div/).text.strip }
  value(:old_subcontractor_active_indicator) { |i=0, b| b.subcontractor_tab.span(id: /document.oldMaintainableObject.(proposal|award)Subcontractors\[#{i}\].active.div/).text.strip }
  action(:result_subcontractor_number) { |i=0, b| b.subcontractor_tab.span(id: /document.newMaintainableObject.(proposal|award)Subcontractors\[#{i}\].subcontractorNumber.div/).text.strip }

end