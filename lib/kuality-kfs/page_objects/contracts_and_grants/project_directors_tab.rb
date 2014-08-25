class ProjectDirectorsTab < PageFactory

  include Utilities
  include GlobalConfig

  element(:new_project_director_principal_name) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)ProjectDirectors.projectDirector.principalName/) }

  element(:new_project_director_primary) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(proposal|award)ProjectDirectors.(proposal|award)PrimaryProjectDirectorIndicator/) }
  element(:new_project_director_title) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)ProjectDirectors.(proposal|award)ProjectDirectorProjectTitle/) }
  element(:new_project_director_active_indicator) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(proposal|award)ProjectDirectors.active/) }
  action(:add_new_project_director) { |b| b.frm.button(id: /^methodToCall\.addLine\.(proposal|award)ProjectDirectors/).click }
  action(:delete_project_director) { |i=0, b| b.frm.button(id: /methodToCall.deleteLine.(proposal|award)ProjectDirectors.\(!!.line#{i}/).click }
  element(:project_director_tab) { |b| b.frm.div(id: 'tab-ProjectDirectors-div') }
  value(:current_project_director_count) { |b| b.project_director_tab.spans(class: 'left', text: /Project Director [(]/m).length }
  action(:update_project_director_principal_name) { |i=0, b| b.project_director_tab.text_field(id: /document.newMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.principalName/) }
  action(:update_project_director_primary) { |i=0, b| b.project_director_tab.text_field(id: /document.newMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.PrimaryProjectDirectorIndicator/) }
  action(:update_project_director_title) { |i=0, b| b.project_director_tab.text_field(id: /document.newMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.ProjectDirectorProjectTitle/) }
  action(:update_project_director_active_indicator) { |i=0, b| b.project_director_tab.text_field(id: /document.newMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.active/) }
  action(:old_project_director_principal_name) { |i=0, b| b.project_director_tab.span(id: /document.oldMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.principalName.div/).text.strip }
  action(:old_project_director_primary) { |i=0, b| b.project_director_tab.span(id: /document.oldMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.PrimaryProjectDirectorIndicator.div/).text.strip }
  action(:old_project_director_title) { |i=0, b| b.project_director_tab.span(id: /document.oldMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.ProjectDirectorProjectTitle.div/).text.strip }
  action(:old_project_director_active_indicator) { |i=0, b| b.project_director_tab.span(id: /document.oldMaintainableObject.(proposal|award)ProjectDirectors\[#{i}\].projectDirector.active.div/).text.strip }

end