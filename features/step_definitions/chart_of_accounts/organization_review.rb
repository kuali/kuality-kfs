And /^I edit an Organization Review$/ do
  visit(MainPage).organization_review
  on OrganizationReviewLookupPage do |page|
    page.search
    page.edit_random
  end
  on OrganizationReviewPage do |page|
    @organization_review = make OrganizationReviewObject
    page.description.set random_alphanums(40, 'AFT')
    @organization_review.document_id = page.document_id
    page.save
  end
end
