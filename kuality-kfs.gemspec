Gem::Specification.new do |s|
    s.name = 'kuality-kfs'
    s.version = '0.0.2'
    s.summary = %q{Kuali Financial System Community framework for testing}
    s.description = %q{This gem provides the core data and page objects for building KFS tests}
    s.files = Dir.glob("**/**/**")
    s.test_files = Dir.glob("test/*test_rb")
    s.authors = ["Cornell University"]
    s.email = %w{"tony@rsmart.com"}
    s.homepage = 'https://github.com/CU-CommunityApps'
    s.add_dependency 'test-factory', '0.4.6'
    s.required_ruby_version = '>= 1.9.2'
end
