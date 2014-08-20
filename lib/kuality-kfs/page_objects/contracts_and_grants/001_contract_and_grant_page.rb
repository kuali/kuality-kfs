class ContractAndGrantPage < KFSBasePage

  class << self

    def common_fields
      element(:agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
      element(:award_type) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalAwardTypeCode') }
      element(:grant_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposal.grantNumber') }
      element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
      element(:old_agency_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.agencyNumber.div').text.strip }
      element(:old_award_type) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalAwardTypeCode.div').text.strip }
      element(:old_grant_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposal.grantNumber.div').text.strip }
      element(:old_proposal_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalNumber.div').text.strip }

    end
    def organization_lines
      element(:cg_new_organization_chart_code) { |t,b| b.frm.select(name: "document.newMaintainableObject.add.#{t}Organizations.chartOfAccountsCode") }
      element(:cg_new_organization_code) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}Organizations.organizationCode") }
      element(:cg_new_organization_primary) { |t,b| b.frm.checkbox(name: "document.newMaintainableObject.add.#{t}Organizations.#{t}PrimaryOrganizationIndicator") }
      element(:cg_new_organization_active_indicator) { |t,b| b.frm.checkbox(name: "document.newMaintainableObject.add.#{t}Organizations.active") }
      action(:cg_add_new_organization) { |t,b| b.frm.button(id: /^methodToCall\.addLine\.#{t}Organizations/).click }

      action(:cg_delete_organization) { |t,i=0, b| b.frm.button(id: "methodToCall.deleteLine.#{t}Organizations.(!!.line#{i}").click }
      element(:cg_organization_tab) { |b| b.frm.div(id: 'tab-Organizations-div') }
      value(:cg_current_organization_count) { |b| b.organization_tab.spans(class: 'left', text: /Organization [(]/m).length }
      action(:cg_update_organization_chart_code) { |t, i=0, b|
        b.cg_organization_tab.span(id: "document.newMaintainableObject.#{t}Organizations[#{i}].chartOfAccountsCode.div")
      }
      action(:cg_update_organization_code) { |t, i=0, b|
        b.cg_organization_tab.span(id: "document.newMaintainableObject.#{t}Organizations[#{i}].organizationCode.div")
      }
      action(:cg_update_organization_primary) { |t,i=0, b| b.cg_organization_tab.text_field(id: "document.newMaintainableObject.#{t}Organizations[#{i}].#{t}PrimaryOrganizationIndicator") }
      action(:cg_update_organization_active_indicator) { |t,i=0, b| b.cg_organization_tab.text_field(id: "document.newMaintainableObject.#{t}Organizations[#{i}].active") }
      action(:cg_old_organization_chart_code) { |t,i=0, b| b.organization_tab.span(id: "document.oldMaintainableObject.#{t}Organizations[#{i}].chartOfAccountsCode.div").text.strip }
      action(:cg_old_organization_code) { |t,i=0, b| b.organization_tab.span(id: "document.oldMaintainableObject.#{t}Organizations[#{i}].organizationCode.div").text.strip }
      action(:cg_old_organization_primary) { |t,i=0, b| b.organization_tab.span(id: "document.oldMaintainableObject.#{t}Organizations[#{i}].#{t}PrimaryOrganizationIndicator.div").text.strip }
      action(:cg_old_organization_active_indicator) { |t,i=0, b| b.organization_tab.span(id: "document.oldMaintainableObject.#{t}Organizations[#{i}].active.div").text.strip }
      action(:cg_result_organization_code) { |t,i=0, b| b.organization_tab.span(id: "document.newMaintainableObject.#{t}Organizations[#{i}].organizationCode.div").text.strip }
      action(:cg_result_organization_chart_code) { |t,i=0, b| b.organization_tab.span(id: "document.newMaintainableObject.#{t}Organizations[#{i}].chartOfAccountsCode.div").text.strip }
      alias_method :organization_tab,:cg_organization_tab
      alias_method :current_organization_count,:cg_current_organization_count
    end

    def project_director_lines
      element(:cg_new_project_director_principal_name) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}ProjectDirectors.projectDirector.principalName") }

      element(:cg_new_project_director_primary) { |t,b| b.frm.checkbox(name: "document.newMaintainableObject.add.#{t}ProjectDirectors.#{t}PrimaryProjectDirectorIndicator") }
      element(:cg_new_project_director_title) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}ProjectDirectors.#{t}ProjectDirectorProjectTitle") }
      element(:cg_new_project_director_active_indicator) { |t,b| b.frm.checkbox(name: "document.newMaintainableObject.add.#{t}ProjectDirectors.active") }
      action(:cg_add_new_project_director) { |t,b| b.frm.button(id: /^methodToCall\.addLine\.#{t}ProjectDirectors/).click }
      action(:cg_delete_project_director) { |t,i=0, b| b.frm.button(id: "methodToCall.deleteLine.#{t}ProjectDirectors.(!!.line#{i}").click }
      element(:cg_project_director_tab) { |b| b.frm.div(id: 'tab-ProjectDirectors-div') }
      value(:cg_current_project_director_count) { |b| b.project_director_tab.spans(class: 'left', text: /Project Director [(]/m).length }
      action(:cg_update_project_director_principal_name) { |t,i=0, b| b.project_director_tab.text_field(id: "document.newMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.principalName") }
      action(:cg_update_project_director_primary) { |t,i=0, b| b.project_director_tab.text_field(id: "document.newMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.PrimaryProjectDirectorIndicator") }
      action(:cg_update_project_director_title) { |t,i=0, b| b.project_director_tab.text_field(id: "document.newMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.ProjectDirectorProjectTitle") }
      action(:cg_update_project_director_active_indicator) { |t,i=0, b| b.project_director_tab.text_field(id: "document.newMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.active") }
      action(:cg_old_project_director_principal_name) { |t,i=0, b| b.project_director_tab.span(id: "document.oldMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.principalName.div").text.strip }
      action(:cg_old_project_director_primary) { |t,i=0, b| b.project_director_tab.span(id: "document.oldMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.PrimaryProjectDirectorIndicator.div").text.strip }
      action(:cg_old_project_director_title) { |t,i=0, b| b.project_director_tab.span(id: "document.oldMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.ProjectDirectorProjectTitle.div").text.strip }
      action(:cg_old_project_director_active_indicator) { |t,i=0, b| b.project_director_tab.span(id: "document.oldMaintainableObject.#{t}ProjectDirectors[#{i}].projectDirector.active.div").text.strip }
      alias_method :project_director_tab,:cg_project_director_tab
      alias_method :current_project_director_count, :cg_current_project_director_count

    end

    def subcontractor_lines
      element(:cg_new_subcontractor_number) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}Subcontractors.subcontractorNumber") }
      element(:cg_new_subcontractor_description) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}Subcontractors.#{t}SubcontractorDescription") }
      element(:cg_new_subcontractor_amount) { |t,b| b.frm.text_field(name: "document.newMaintainableObject.add.#{t}Subcontractors.subcontractorAmount") }
      element(:cg_new_subcontractor_active_indicator) { |t,b| b.frm.checkbox(name: "document.newMaintainableObject.add.#{t}Subcontractors.active") }
      action(:cg_add_new_subcontractor) { |t,b| b.frm.button(id: /^methodToCall\.addLine\.#{t}Subcontractors/).click }
      action(:cg_delete_subcontractor) { |t,i=0, b| b.frm.button(id: "methodToCall.deleteLine.#{t}Subcontractors.(!!.line#{i}").click }
      element(:cg_subcontractor_tab) { |b| b.frm.div(id: 'tab-Subcontractors-div') }
      value(:cg_current_subcontractor_count) { |b| b.cg_subcontractor_tab.spans(class: 'left', text: /Subcontractor [(]/m).length }
      action(:cg_update_subcontractor_number) { |t, i=0, b|
        b.cg_subcontractor_tab.span(id: "document.newMaintainableObject.#{t}Subcontractors[#{i}].subcontractorNumber.div")
      }
      action(:cg_update_subcontractor_description) { |t,i=0, b| b.cg_subcontractor_tab.text_field(id: "document.newMaintainableObject.#{t}Subcontractors[#{i}].#{t}SubcontractorDescription") }
      action(:cg_update_subcontractor_amount) { |t,i=0, b| b.cg_subcontractor_tab.text_field(id: "document.newMaintainableObject.#{t}Subcontractors[#{i}].subcontractorAmount") }
      action(:cg_update_subcontractor_active_indicator) { |t,i=0, b| b.cg_subcontractor_tab.text_field(id: "document.newMaintainableObject.#{t}Subcontractors[#{i}].active") }
      value(:cg_old_subcontractor_number) { |t,i=0, b| b.cg_subcontractor_tab.span(id: "document.oldMaintainableObject.#{t}Subcontractors[#{i}].subcontractorNumber.div").text.strip }
      value(:cg_old_subcontractor_description) { |t,i=0, b| b.cg_subcontractor_tab.span(id: "document.oldMaintainableObject.#{t}Subcontractors[#{i}].#{t}SubcontractorDescription.div").text.strip }
      value(:cg_old_subcontractor_amount) { |t,i=0, b| b.cg_subcontractor_tab.span(id: "document.oldMaintainableObject.#{t}Subcontractors[#{i}].subcontractorAmount.div").text.strip }
      value(:cg_old_subcontractor_active_indicator) { |t,i=0, b| b.cg_subcontractor_tab.span(id: "document.oldMaintainableObject.#{t}Subcontractors[#{i}].active.div").text.strip }
      action(:cg_result_subcontractor_number) { |t,i=0, b| b.cg_subcontractor_tab.span(id: "document.newMaintainableObject.#{t}Subcontractors[#{i}].subcontractorNumber.div").text.strip }
      alias_method :subcontractor_tab,:cg_subcontractor_tab
      alias_method :current_subcontractor_count, :cg_current_subcontractor_count

    end


  end
end
