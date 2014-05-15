class SalaryExpenseTransferPage < LaborDistributionPage

  element(:import_empl_id) { |b| b.frm.text_field(name: 'document.emplid') }
  action(:search_empl_id) { |b| b.frm.button(title: 'Search').click }

end