class AwardInquiryPage < KFSBasePage

  value(:grant_number) { |b| b.frm.span(id: 'proposal.grantNumber.div').text.strip }


end
