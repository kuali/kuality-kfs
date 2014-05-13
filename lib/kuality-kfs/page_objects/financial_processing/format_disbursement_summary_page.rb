class FormatDisbursementSummaryPage < KFSBasePage

  action(:continue_format) { |b| b.frm.button(name: 'methodToCall.continueFormat').click }
end
