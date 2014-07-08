class SalaryExpenseTransferPage < LaborDistributionPage

  element(:employee_id) { |b| b.frm.text_field(name: 'document.emplid') }
  action(:search_empl_id) { |b| b.frm.button(name: /^methodToCall.performLookup.\(!!org.kuali.rice.kim.api.identity.Person!!\)/m).click }

end