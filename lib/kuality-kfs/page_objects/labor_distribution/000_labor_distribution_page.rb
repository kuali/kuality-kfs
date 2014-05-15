class LaborDistributionPage < FinancialProcessingPage

  accounting_lines
  action(:import_search) { |b| b.frm.button(title: 'search', name: /methodToCall.performBalanceInquiryLookup/m).click }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  action(:search_fiscal_year) { |b| b.frm.button(title: 'Search Fiscal Year').click }

end