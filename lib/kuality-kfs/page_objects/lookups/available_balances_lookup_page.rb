class AvailableBalancesLookupPage < Lookups

  document_facets
  fiscal_officer_facets
  account_facets
  subaccount_facets
  financial_object_facets
  fiscal_year_facets
  include_pending_ledger_entry_radios
  consolidation_option_radios

end