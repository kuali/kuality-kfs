class DisbursementVoucherPage < FinancialProcessingPage

  #element(:) { |b| b.frm.select(name: 'document.disbVchrPaymentMethodCode') }
  #element(:) { |b| b.frm.select(name: 'document.disbursementVoucherDocumentationLocationCode') }
  #element(:) { |b| b.frm.select(name: 'newSourceLine.chartOfAccountsCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvPayeeDetail.disbVchrSpecialHandlingCountryCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvWireTransfer.disbVchrCurrencyTypeCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvWireTransfer.disbVchrBankCountryCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrTravelFromStateCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.dvTravelFromCountryCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrTravelToStateCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrTravelToCountryCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrPerdiemCategoryName') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrAutoFromStateCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvNonEmployeeTravel.disbVchrAutoToStateCode') }
  #element(:) { |b| b.frm.select(name: 'newNonEmployeeExpenseLine.disbVchrExpenseCode') }
  #element(:) { |b| b.frm.select(name: 'newPrePaidNonEmployeeExpenseLine.disbVchrPrePaidExpenseCode') }
  #element(:) { |b| b.frm.select(name: 'document.dvPreConferenceDetail.disbVchrExpenseCode') }
  #element(:) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
  #element(:) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }


  action(:calculate_per_diem) { |b| b.frm.button(title: 'Calculate Per Diem').click }

  action(:calculate_total_mileage) { |b| b.frm.button(title: 'Calculate Total Mileage').click }

  action(:add_expense_line) { |b| b.frm.button(title: 'Add Expense Line').click }

  action(:add_pre_conference_registrant_line) { |b| b.frm.button(title: 'Add Pre-Conference Registrant Line').click }

  action(:cancel_attachment) { |b| b.frm.button(title: 'Cancel Attachment').click }



end