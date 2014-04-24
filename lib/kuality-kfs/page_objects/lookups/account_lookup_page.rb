class AccountLookupPage < Lookups

  account_facets
  organization_facets
  fiscal_officer_facets
  selection_actions

  action(:get_random_account_number) do |b|
      b.closed_no.set
      b.search
      b.wait_for_search_results
      b.return_random_row[2].text
  end

end