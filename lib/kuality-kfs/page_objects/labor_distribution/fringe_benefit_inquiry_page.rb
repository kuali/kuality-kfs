class FringeBenefitInquiryPage < KFSBasePage

  element(:fringe_benefit_detail_table) { |b| b.frm.div(id:'tab-FringeBenefitDetail-div').div(id: 'workarea').table }

end