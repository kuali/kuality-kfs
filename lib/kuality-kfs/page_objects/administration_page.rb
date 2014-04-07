class AdministrationPage < BasePage

  page_url "#{$base_url}portal.do?selectedTab=administration"

  links 'Person', 'Group', 'Role',
        # Parameters
        'Namespace', 'Parameter', 'Parameter Component', 'Parameter Type',
        'Cache Admin'

end