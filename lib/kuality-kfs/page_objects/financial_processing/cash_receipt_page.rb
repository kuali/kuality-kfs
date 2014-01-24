class CashReceiptPage < BasePage

  element(:explaination) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }
  element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }

#CURRENCY AND COIN DETAIL
  element(:hundred_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.hundredDollarCount') }
  element(:hundred_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.hundredCentCount') }
  element(:fifty_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.fiftyDollarCount') }
  element(:fifty_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.fiftyCentCount') }
  element(:twenty_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.twentyDollarCount') }
  element(:twenty_five_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.twentyFiveCentCount') }
  element(:ten_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.tenDollarCount') }
  element(:ten_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.tenCentCount') }
  element(:five_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.fiveDollarCount') }
  element(:five_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.fiveCentCount') }
  element(:two_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.twoDollarCount') }
  element(:one_cent_count) { |b| b.frm.text_field(name: 'document.coinDetail.oneCentCount') }
  element(:one_dollar_count) { |b| b.frm.text_field(name: 'document.currencyDetail.oneDollarCount') }
  element(:other_cent_amount) { |b| b.frm.text_field(name: 'document.coinDetail.financialDocumentOtherCentAmount') }
  element(:other_dollar_amount) { |b| b.frm.text_field(name: 'document.currencyDetail.financialDocumentOtherDollarAmount') }

#CHECK DETAIL
  element(:check_number) { |b| b.frm.text_field(name: 'newCheck.checkNumber') }
  element(:check_date) { |b| b.frm.text_field(name: 'newCheck.checkDate') }
  element(:check_description) { |b| b.frm.text_field(name: 'newCheck.description') }
  element(:check_amount) { |b| b.frm.text_field(name: 'newCheck.amount') }
  action(:add_check_detail) { |b| b.frm.button(name: 'methodToCall.addCheck').click }


#ACCOUNTING LINES
  element(:account_number) { |b| b.frm.text_field(name: 'newSourceLine.accountNumber') }
  element(:sub_account_number) { |b| b.frm.text_field(name: 'newSourceLine.subAccountNumber') }
  element(:object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialObjectCode') }
  element(:sub_object_code) { |b| b.frm.text_field(name: 'newSourceLine.financialSubObjectCode') }
  element(:project_code) { |b| b.frm.text_field(name: 'newSourceLine.projectCode') }
  element(:org_ref_id) { |b| b.frm.text_field(name: 'newSourceLine.organizationReferenceId') }
  element(:line_description) { |b| b.frm.text_field(name: 'newSourceLine.financialDocumentLineDescription') }

  action(:add_accounting_line) { |b| b.frm.button(name: 'methodToCall.insertSourceLine.anchoraccountingSourceAnchor').click }
#NOTES
  element(:note_text) { |b| b.frm.text_field(name: 'newNote.noteText') }
#AD HOC RECIPIENTS
  element(:ad_hoc_person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  element(:ad_hoc_name_space_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
  element(:ad_hoc_group_name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }



end