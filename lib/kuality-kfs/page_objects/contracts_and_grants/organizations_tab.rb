class OrganizationsTab < PageFactory

  include Utilities
  include GlobalConfig

  element(:new_organization_chart_code) { |b| b.frm.select(name: /document.newMaintainableObject.add.(proposal|award)Organizations.chartOfAccountsCode/) }
  element(:new_organization_code) { |b| b.frm.text_field(name: /document.newMaintainableObject.add.(proposal|award)Organizations.organizationCode/) }
  element(:new_organization_primary) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(proposal|award)Organizations.(proposal|award)PrimaryOrganizationIndicator/) }
  element(:new_organization_active_indicator) { |b| b.frm.checkbox(name: /document.newMaintainableObject.add.(proposal|award)Organizations.active/) }
  action(:add_new_organization) { |b| b.frm.button(id: /^methodToCall\.addLine\.(proposal|award)Organizations/).click }

  action(:delete_organization) { |i=0, b| b.frm.button(id: /methodToCall.deleteLine.(proposal|award)Organizations.\(!!.line#{i}/).click }
  element(:organization_tab) { |b| b.frm.div(id: 'tab-Organizations-div') }
  value(:current_organization_count) { |b| b.organization_tab.spans(class: 'left', text: /Organization [(]/m).length }
  action(:update_organization_chart_code) { | i=0, b|
    b.organization_tab.span(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].chartOfAccountsCode.div/)
  }
  action(:update_organization_code) { | i=0, b|
    b.organization_tab.span(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].organizationCode.div/)
  }
  action(:update_organization_primary) { |i=0, b| b.organization_tab.text_field(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].(proposal|award)PrimaryOrganizationIndicator/) }
  action(:update_organization_active_indicator) { |i=0, b| b.organization_tab.text_field(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].active/) }
  action(:old_organization_chart_code) { |i=0, b| b.organization_tab.span(id: /document.oldMaintainableObject.(proposal|award)Organizations\[#{i}\].chartOfAccountsCode.div/).text.strip }
  action(:old_organization_code) { |i=0, b| b.organization_tab.span(id: /document.oldMaintainableObject.(proposal|award)Organizations\[#{i}\].organizationCode.div/).text.strip }
  action(:old_organization_primary) { |i=0, b| b.organization_tab.span(id: /document.oldMaintainableObject.(proposal|award)Organizations\[#{i}\].(proposal|award)PrimaryOrganizationIndicator.div/).text.strip }
  action(:old_organization_active_indicator) { |i=0, b| b.organization_tab.span(id: /document.oldMaintainableObject.(proposal|award)Organizations\[#{i}\].active.div/).text.strip }
  action(:result_organization_code) { |i=0, b| b.organization_tab.span(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].organizationCode.div/).text.strip }
  action(:result_organization_chart_code) { |i=0, b| b.organization_tab.span(id: /document.newMaintainableObject.(proposal|award)Organizations\[#{i}\].chartOfAccountsCode.div/).text.strip }
  value(:organization_errors) { |b| b.organization_tab.div(class: 'left-errmsg-tab').div.divs.collect{ |div| div.text }  }
end