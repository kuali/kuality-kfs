class MainPage < BasePage

  page_url "#{$base_url}portal.jsp"

  links 'Advance Deposit', 'Schedule'

  #Capital Asset Builder
  links 'Pre-Asseet Tagging',
  #Capital Asset Management
  'Asset', 'Asset Fabication', 'Asset Location Global', 'Asset Payment', 'Asset Retirement Global'

  action(:asset_global_add) { |b| b.link(text: 'Asset Global (Add)').click }

  #Chart of Acconts
  links 'Account', 'Account Global', 'Account Delegate', 'Account Delegate Global', 'Account Delegate Model',
        'Account Delegate Global From Model', 'Object Code', 'Object Code Global', 'Organization', 'Organization Review',
        'Project Code', 'Sub-Account', 'Sub-Object Code', 'Sub-Object Code Global',
  # FYI: for links, special characters like '-' will be changed to underscore '_' just like spaces, so Sub-Account becomes :sub_account

  #Contracts and Grants
  'Award', 'Proposal',
  #Financial Processing
  'Disbursement Voucher Travel Company',
  #Global Favorites
  'User Favorite Accounts',
  #Vender
  'Vendor', 'Vendor Contracts'


end