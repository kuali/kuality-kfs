class PrePaidTravelExpensesTab < FinancialProcessingPage

  action(:labelled_fields) { |s, b| b.frm.th(text: /#{s}/m).parent.tds(class: 'datacell') }
  action(:labelled_field) { |s, c=0, b| b.labelled_fields(s)[c] }

  element(:location) { |b| b.frm.text_field(id: 'document.dvPreConferenceDetail.dvConferenceDestinationName') }
  element(:type) { |b| b.frm.select(id: 'document.dvPreConferenceDetail.disbVchrExpenseCode') }
  element(:start_date) { |b| b.frm.text_field(id: 'document.dvPreConferenceDetail.disbVchrConferenceStartDate') }
  element(:end_date) { |b| b.frm.text_field(id: 'document.dvPreConferenceDetail.disbVchrConferenceEndDate') }

  element(:name) { |b| b.frm.text_field(id: 'newPreConferenceRegistrantLine.dvConferenceRegistrantName') }
  element(:department_code) { |b| b.frm.text_field(id: 'newPreConferenceRegistrantLine.disbVchrPreConfDepartmentCd') }
  element(:req_instate) { |b| b.frm.text_field(id: 'newPreConferenceRegistrantLine.dvPreConferenceRequestNumber') }
  element(:amount) { |b| b.frm.text_field(id: 'newPreConferenceRegistrantLine.disbVchrExpenseAmount') }

  element(:add_pre_paid_expense_button) { |b| b.frm.button(name: 'methodToCall.addPreConfRegistrantLine') }
  action(:add_pre_paid_expense) { |b| b.add_pre_paid_expense_button.click }

end
