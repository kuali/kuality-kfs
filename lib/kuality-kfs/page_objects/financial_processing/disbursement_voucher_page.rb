class DisbursementVoucherPage < FinancialProcessingPage

  accounting_lines
  ad_hoc_recipients

  element(:foreign_draft_in) { |v, b| b.frm.radio(name: 'document.wireTransfer.foreignCurrencyTypeCode', value: v) }
  element(:foreign_draft_in_usd) { |b| b.foreign_draft_in('C') }
  element(:foreign_draft_in_foreign_currency) { |b| b.foreign_draft_in('F') }
  element(:currency_type) { |b| b.frm.text_field(id: 'document.wireTransfer.foreignCurrencyTypeName') }

  element(:contact_name) { |b| b.frm.text_field(id: 'document.disbVchrContactPersonName') }
  element(:phone_number) { |b| b.frm.text_field(id: 'document.disbVchrContactPhoneNumber') }
  element(:email_address) { |b| b.frm.text_field(id: 'document.disbVchrContactEmailId') }
  element(:car_mileage) { |b| b.frm.text_field(id: 'document.dvNonEmployeeTravel.dvPersonalCarMileageAmount') }
  element(:car_mileage_reimb_amt) { |b| b.frm.text_field(name: 'document.dvNonEmployeeTravel.disbVchrPersonalCarAmount') }
  element(:per_diem_start_date) { |b| b.frm.text_field(name: 'document.dvNonEmployeeTravel.perDiemStartDateTime') }
  action(:calc_mileage_amount) { |b| b.frm.button(name: /methodToCall.calculateTravelMileageAmount/m).click }

  value(:bank_code) { |b| b.frm.table(summary: 'Advance Deposits').td(class: 'infoline').text }
  value(:bank_code_full) { |b| b.frm.table(summary: 'KFS Detail Section').td(class: 'datacell-nowrap').text }
  action(:bank_search) { |b| b.frm.button(name: /methodToCall.performLookup.\(!!org.kuali.kfs.sys.businessobject.Bank!!\)/m).click }
#        #returns  "DISB\nMellon Controlled Disbursement Account "
#  value(:bank_code_bank_text) { |b| b.frm.table(summary: 'KFS Detail Section').div(id: 'document.bank.div').text }
#        #returns "Mellon Controlled Disbursement Account "
end