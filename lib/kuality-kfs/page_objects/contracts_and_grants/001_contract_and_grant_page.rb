class ContractAndGrantBasePage < KFSBasePage

  class << self

    def cg_base
      element(:agency_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.agencyNumber') }
      element(:award_type) { |b| b.frm.select(name: 'document.newMaintainableObject.proposalAwardTypeCode') }
      element(:grant_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.proposal.grantNumber') }
      element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }
      element(:old_agency_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.agencyNumber.div').text.strip }
      element(:old_award_type) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalAwardTypeCode.div').text.strip }
      element(:old_grant_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposal.grantNumber.div').text.strip }
      element(:old_proposal_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.proposalNumber.div').text.strip }

    end
  end
end
