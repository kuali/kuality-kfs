And /^I add e\-SHOP items to my cart until the cart total reaches the Business to Business Total Amount For Automatic Purchase Order limit$/ do
  on ShopResultsPage do |page|
    item = 0
    target_value = page.price_for_item item
    target_quantity = ((get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_AUTO_PO', 'Requisition').first.to_f -
        page.cart_total_value.to_f) /
        target_value).ceil
    target_quantity.should be > 0, 'There are already one or more items in your shopping cart such that we cannot add an additional item!'
    page.item_quantity(item).fit target_quantity
    page.add_item item
    page.cart_total_value.to_f.should be >= get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_AUTO_PO', 'Requisition').first.to_f
    page.cart_total_value.to_f.should be < get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_SUPER_USER_AUTO_PO', 'Requisition').first.to_f
  end
end

And /^I add a note to my e\-SHOP cart$/ do
  @eshop_cart.add_note 'Wow! That is a sweet note, you might say!'
end

And /^I submit my e\-SHOP cart$/ do
  # We're assuming you're already on the e-SHOP cart page here.
  @eshop_cart.submit
  #sometimes this page is blank because test is moving too fast
  # on(RequisitionPage).description.wait_until_present(60)

  on RequisitionPage do |page|
    # Surprise! This should kick you out to a Requisition document.
    page.doc_title.strip.should == 'Requisition'
    if page.delivery_phone_number.value.strip.empty? || page.delivery_phone_number.value == 'null'
      page.delivery_phone_number.fit random_phone_number
    end
  end
  @requisition = make RequisitionObject
  @requisition.absorb! :new
end

Then /^Payment Request Positive Approval Required is (not required|required)$/ do |is_required|
  if is_required == 'required'
    @requisition.payment_request_positive_approval_required.set?.true?.should
    on(RequisitionPage).result_payment_request_positive_approval_required.should == 'Yes'
  else
    @requisition.payment_request_positive_approval_required.set?.false?.should
    on(RequisitionPage).result_payment_request_positive_approval_required.should == 'No'
  end
end

And /^the e\-SHOP cart has an associated Requisition document$/ do
  # You need to have to have already pulled up the Req doc, naturally
  @requisition.description.should == @eshop_cart.cart_name
end

When /^I go to the e\-SHOP main page$/ do
  visit(MainPage).e_shop
  on EShopPage do |page|
    if page.announcements_block.exists?
      page.clear_announcement
      page.goto_home
    end
  end
end

When /^I view my e\-SHOP cart$/ do
  # We're going to assume you want to update this guy
  # if you're checking out your cart...
  @eshop_cart = make EShopCartObject if @eshop_cart.nil?
  @eshop_cart.view # This assumes you're at least in the e-SHOP, naturally
  @eshop_cart.absorb!
end

When /^I clear my e\-SHOP cart$/ do
  @eshop_cart.clear_items
end

Given /^I initiate an e\-SHOP order$/ do
  step 'I am logged in as an e-SHOP Plus User'
  step 'I go to the e-SHOP main page'
  step 'I view my e-SHOP cart'
  step 'I clear my e-SHOP cart'
  step 'I go to the e-SHOP main page'
  step 'I search for an e-SHOP item with a Non-Sensitive Commodity Code'
  step 'I add e-SHOP items to my cart until the cart total reaches the Business to Business Total Amount For Automatic Purchase Order limit'
  step 'I view my e-SHOP cart'
  step 'I add a note to my e-SHOP cart'
  step 'I submit my e-SHOP cart'
  step 'I add a random address to the Delivery tab on the Requisition document'
  step 'I add a random Requestor Phone number to the Requisition document'
  step 'I add these Accounting Lines to Item #1 on the Requisition document:',
       table(%q{
            | Chart Code | Account Number       | Object Code | Amount |
            | Default    | Unrestricted Account | Expenditure | 10     |
          })
  step 'I add an attachment to the Requisition document'
  step 'I add a file attachment to the Notes and Attachment Tab of the Requisition document'
  step 'I calculate the Requisition document'
  step 'I submit the Requisition document'
  step 'the document should have no errors'
  step 'I reload the Requisition document'
  step 'Payment Request Positive Approval Required is required'
end

And /^I add over \$(.*) worth of e\-SHOP items to my cart$/ do |amount|
  on ShopResultsPage do |page|
    item = 0
    target_value = page.price_for_item item
    target_quantity = amount.to_f / target_value
    puts target_quantity.ceil
    page.item_quantity(item).fit target_quantity.ceil
    page.add_item item
  end
end

And	 /^I change to Capital Asset object code$/ do
  on(RequisitionPage).expand_all
  on(ItemsTab).update_object_code.fit fetch_random_capital_asset_object_code
end

And /^the Vendor Choice is populated$/ do
  !on(PurchaseOrderPage).result_vendor_choice.empty?.should
end

And /^I can not search and retrieve the Payment Request document$/ do
  visit(MainPage).payment_requests
  on DocumentSearch do |page|
    page.document_id.fit @payment_request.document_id
    page.search
    step 'I should get an error saying "1 rows were filtered for security purposes."'
  end
end


And /^I add e\-SHOP items to my cart with a value of at least (\d*)$/ do  |min_amount|
  on ShopResultsPage do |page|
    item = 0
    target_value = page.price_for_item item
    target_quantity = ((min_amount.to_f - page.cart_total_value.to_f )/target_value).ceil

    target_quantity.should be > 0, 'There are already one or more items in your shopping cart such that we cannot add an additional item!'
    page.item_quantity(item).fit target_quantity
    page.add_item item
  end
end

Given  /^I create an e-SHOP Requisition document with a (.*) item type$/ do |item_type|
  step 'I am logged in as an e-SHOP User'
  step 'I go to the e-SHOP main page'
  step 'I view my e-SHOP cart'
  step 'I clear my e-SHOP cart'
  step 'I go to the e-SHOP main page'
  step "I search for an e-SHOP item with a #{item_type} Commodity Code"
  step 'I add e-SHOP items to my cart until the cart total reaches the Business to Business Total Amount For Automatic Purchase Order limit'
  step 'I view my e-SHOP cart'
  step 'I add a note to my e-SHOP cart'
  step 'I submit my e-SHOP cart'
  step 'I add a random address to the Delivery tab on the Requisition document'
  step 'I add a random Requestor Phone number to the Requisition document'
  step 'I capture the Requisition document id number'
end

Given  /^I create an e-SHOP Requisition document with a (.*) item type that is at least (.*) in value$/ do |item_type, min_cart_value|
  step 'I am logged in as an e-SHOP User'
  step 'I go to the e-SHOP main page'
  step 'I view my e-SHOP cart'
  step 'I clear my e-SHOP cart'
  step 'I go to the e-SHOP main page'
  step "I search for an e-SHOP item with a #{item_type} Commodity Code"
  step "I add e-SHOP items to my cart with a value of at least #{min_cart_value}"
  # step 'I add e-SHOP items to my cart until the cart total reaches the Business to Business Total Amount For Automatic Purchase Order limit'
  step 'I view my e-SHOP cart'
  step 'I add a note to my e-SHOP cart'
  step 'I submit my e-SHOP cart'
  step 'I add a random address to the Delivery tab on the Requisition document'
  step 'I add a random Requestor Phone number to the Requisition document'
end

When /^I route the e-SHOP Requisition document through SciQuest until the Payment Request document is ENROUTE$/ do
  step 'I add these Accounting Lines to Item #1 on the Requisition document:',
       table(%q{
        | chart_code | account_number       | object_code | percent |
        | Default    | Unrestricted Account | Expenditure | 100     |
  })
  step 'I select the Payment Request Positive Approval Required'
  step 'I add a random delivery address to the Requisition document if there is not one present'
  step 'I add a random phone number to the Requestor Phone on the Requisition document'
  step 'I calculate the Requisition document'
  step 'I submit the Requisition document'
  step 'the Requisition document goes to ENROUTE'
  step 'I switch to the user with the next Pending Action in the Route Log to approve Requisition document to Final'
  step 'the Requisition document goes to FINAL'
  step 'I extract the Requisition document to SciQuest'
  step 'I submit a Payment Request document to ENROUTE'
end


