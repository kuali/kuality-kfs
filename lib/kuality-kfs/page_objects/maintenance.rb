class MaintenancePage < BasePage
  page_url "#{$base_url}portal.do?selectedTab=maintenance"

  tab_buttons

  links 'Indirect Cost Recovery Rate','Format Checks/ACH','CG Reporting Code'

end