class IndirectCostRecoveryRateLookupPage < BasePage

  tiny_buttons
  search_results_table

  element(:university_fiscal_year) { |b| b.frm.text_field(name: 'universityFiscalYear') }
  element(:rate_id) { |b| b.frm.text_field(name: 'financialIcrSeriesIdentifier') }
  action(:active_indicator_yes) { |b| b.frm.radio(id: 'activeYes').set }
  action(:active_indicator_no) { |b| b.frm.radio(id: 'activeNo').set }
  action(:active_indicator_both) { |b| b.frm.radio(id: 'activeBoth').set }
end