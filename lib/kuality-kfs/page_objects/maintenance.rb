class MaintenancePage < BasePage

  page_url "#{$base_url}portal.do?selectedTab=maintenance"

  tab_buttons

  action(:dept_kfs_organization_crosswalk) {|b| b.frm.link(text: 'Dept - KFS Organization Crosswalk').click }
  action(:proposal_award_close) {|b| b.frm.link(text: 'Proposal/Award Close').click }
  action(:format_checks_ach) {|b| b.frm.link(text: 'Format Checks/ACH').click }


  links 'Account Reversion', 'Account Reversion Global', 'Account Type',
      'Accounting Period', 'AICPA Function', 'Appropriation Account', 'Balance Type',
      'Basic Accounting Category', 'Budget Aggregation Code', 'Budget Recording Level',
      'CG Reporting Code', 'Chart', 'Federal Function', 'Federal Funded Code',
      'Financial Reporting Code', 'Fund Group', 'Higher Education Function',
      'Indirect Cost Recovery Rate', 'Indirect Cost Recovery Rate Detail',
      'Indirect Cost Recovery Exclusion By Account', 'Indirect Cost Recovery Type',
      'Indirect Cost Recovery Exclusion By Type', 'Major Reporting Category',
      'Mandatory Transfer Elimination', 'Object Consolidation', 'Object Level',
      'Object Sub-Type', 'Object Type', 'Offset Account', 'Offset Definition',
      'Organization Reversion', 'Organization Reversion Global', 'Organization Reversion Category',
      'Organization Type', 'Responsibility Center', 'Restricted Status', 'Reversion Category',
      'Sub-Fund Group', 'Sub-Fund Program', 'Sub-Fund Group Type',
      'Sufficient Funds Code', 'University Budget Office Function',


      'Cash Drawer', 'Credit Card Type', 'Credit Card Vendor',
      'Disbursement Voucher Batch Defaults', 'Disbursement Voucher Documentation Location',
      'Disbursement Voucher Payment Reason', 'Disbursement Voucher Tax Income Class',
      'Disbursement Voucher Travel Expense Type', 'Disbursement Voucher Travel Mileage Rate',
      'Disbursement Voucher Travel Per Diem', 'Disbursement Voucher Wire Charge',
      'Fiscal Year Function Control', 'Function Control Code', 'Non-Resident Alien Tax Percent',
      'Procurement Card Defaults',


      'Accounting Change Code', 'ACH Bank', 'ACH Transaction Code', 'ACH Transaction Type',
      'Customer Profile', 'Disbursement Number Range', 'Disbursement Type', 'Format Reset',
      'Format Summary', 'Payee ACH Account', 'Payee Type', 'Payment Bank History',
      'Payment Change', 'Payment File Batch Upload', 'Payment Spreadsheet Upload',
      'Payment Type', 'Payment Status', 'Search for Batch', 'Search for Payment',


      'Customer', 'Customer Type', 'Customer Address Type', 'Customer Invoice Item Code',
      'Invoice Recurrence', 'Organization Options', 'Organization Accounting Default',
      'Payment Medium', 'System Information',


      'Address Type', 'Campus Parameter', 'Commodity Code', 'Contact Type', 'Contract Manager',
      'Cost Source', 'Ownership Type', 'Ownership Type Category', 'Payment Terms Type',
      'Phone Type', 'Shipping Payment Terms', 'Shipping Special Conditions', 'Shipping Title',
      'Supplier Diversity', 'Vendor Inactive Reason', 'Vendor Type', 'Vendor Exclusion',
      'Vendor Exclusion Debarred Unmatched',


      'Billing Address', 'Capital Asset System State', 'Capital Asset System Type',
      'Carrier', 'Delivery Required Date Reason', 'Electronic Invoice Item Mapping',
      'Funding Source', 'Item Reason Added', 'Item Type',
      'Method of PO Transmission', 'Negative Payment Request Approval Limit',
      'Organization Parameter', 'Payment Request Auto Approve Exclusions',
      'Purchase Order Contract Language', 'Purchase Order Quote Language',
      'Purchase Order Quote List', 'Purchase Order Quote Status',
      'Purchase Order Vendor Choice', 'Receiving Address','Receiving Threshold',
      'Recurring Payment Frequency', 'Recurring Payment Type', 'Requisition Source',
      'Sensitive Data', 'Vendor Stipulation',


      'Asset Acquisition Type', 'Asset Condition', 'Asset Depreciation Convention',
      'Asset Depreciation Method', 'Asset Location Type', 'Asset Object Code',
      'Asset Retirement Reason', 'Asset Status', 'Asset Transaction Type',
      'Asset Type', 'Asset Payment Document Type',


      'Agency', 'Agency Type', 'Award Status', 'CFDA', 'Grant Description',
      'Invoice Frequency', 'Invoice Type', 'Letter of Credit Fund Group',
      'Proposal Purpose', 'Proposal Status', 'Proposal Type', 'Research Risk Type',
      'Sub-Contractor',


      'Report Definition', 'Report Earn Paygroup', 'Report Period Status Code', 'Report Type',


      'Labor Benefits Calculation', 'Labor Benefits Rate Category', 'Labor Benefits Type',
      'Labor Object Code', 'Labor Object Code Benefits', 'Labor Position Object Group Code',


      'Account Reports', 'Appointment Funding Duration', 'Appointment Funding Reason Code',
      'Budget Construction Position', 'Calculated Salary Foundation Tracker Override',
      'Intended Incumbent', 'Organization Reports',


      'Bank', 'Building', 'Origination Code', 'Room',
      'Tax Region', 'Tax Region Type', 'Unit Of Measure', 'University Date'
end