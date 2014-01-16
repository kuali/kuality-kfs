class MainPage < BasePage
  description_field

  page_url "#{$base_url}portal.jsp"


  action(:asset_global_add) { |b| b.link(text: 'Asset Global (Add)').click }
  action(:outstanding_certifications_by_chart_org_report) { |b| b.frm.link(text: 'Outstanding Certifications by Chart/Org/Report').click }

  action(:account_status_base_funds) { |b| b.link(text: 'Account Status (Base Funds)').click }
  action(:account_status_current_funds) { |b| b.link(text: 'Account Status (Current Funds)').click }



  # browser.links.collect(&:text)
  links 'Cash Control', "Customer Credit Memo", "Customer Invoice", "Customer Invoice Writeoff",
      "Customer Invoice Writeoff Lookup", "Payment Application",

      "Budget Construction Selection",

      "Advance Deposit", "Auxiliary Voucher", "Budget Adjustment", "Cash Receipt", "Credit Card Receipt",
      "Disbursement Voucher", "Distribution of Income and Expense", "General Error Correction", "Indirect Cost Adjustment",
      "Internal Billing", "Intra-Account Adjustment", "Pre-Encumbrance", "Transfer of Funds",

      "Benefit Expense Transfer", "Salary Expense Transfer",

      "Bulk Receiving", "Contract Manager Assignment", "Payment Request", "Receiving", "Requisition",
      "e-SHOP", "I Want", "Vendor Credit Memo",

      "Capital Asset Builder AP Transactions", "Capital Asset Builder GL Transactions",

      "Asset Manual Payment", "Barcode Inventory Process",

      "Effort Certification Recreate",

      "Check Reconciliation", "Reconciliation Report",

      "Cash Management", "General Ledger Correction Process", "Journal Voucher",
      "Non-Check Disbursement", "Service Billing",

      "Labor Journal Voucher", "Labor Ledger Correction Process",

      "Electronic Payment Claim",

      #Coustom Document Searches
      "Financial Transactions",
      #"Customer Invoices",
      "Customer Credit Memos",
      #"Customer Invoice Writeoffs",
      "Cash Controls", "Payment Applications",

      "Asset Maintenance",

      "Effort Certification",

      "Disbursement Vouchers",

      "Electronic Invoice Rejects", "Payment Requests", "Purchase Orders",
      #"Receiving",
      "Requisitions", "Vendor Credit Memos",

      #Lookup and Maintence
      "Pre-Asset Tagging",

      "Asset", "Asset Fabrication",
      ##link created above because of special characters "Asset Global (Add)",
      "Asset Location Global", "Asset Payment", "Asset Retirement Global",

      "Account", "Account Global", "Account Delegate", "Account Delegate Global",
      "Account Delegate Model", "Account Delegate Global From Model", "Object Code", "Object Code Global",
      "Organization", "Organization Review", "Project Code", "Sub-Account", "Sub-Object Code", "Sub-Object Code Global",

      "Award", "Proposal",

      "Disbursement Voucher Travel Company",

      "User Favorite Accounts",

      "Vendor", "Vendor Contracts",

      #Balance Inquiries
      "Available Balances", "Balances by Consolidation", "Cash Balances", "Current Fund Balance",
      "General Ledger Balance", "General Ledger Entry", "General Ledger Pending Entry", "Open Encumbrances",

      #links created above because of special characters "Account Status (Base Funds)", "Account Status (Current Funds)",
      "Calculated Salary Foundation",
      "Employee Funding", "July 1 Position Funding", "Labor Ledger View", "Labor Ledger Pending Entry", "Position Inquiry",

      #Reports
      "Billing Statement", "Customer Aging Report",
      #action(:reports_customer_invoice) { |b| b.link(text: "Customer Invoice").click },


      "Duplicate Certifications Report", "Effort Certification Extract Build",# "Outstanding Certifications by Chart/Org/Report",
      "Outstanding Certifications By Report",

      "Trial Balance",

      "Year End Depreciation", "Year End Budget Adjustment", "Year End Distribution of Income and Expense",
      "Year End General Error Correction", "Year End Transfer of Funds",

      "Year End Benefit Expense Transfer", "Year End Salary Expense Transfer"
end