require 'test-factory'
require 'java'
require "#{File.dirname(__FILE__)}/ext/ksb-client.jar"

java_import 'edu.cornell.ksbclient.KSBServiceClient'
java_import 'org.kuali.rice.kim.v2_0.IdentityService'
java_import 'org.kuali.rice.kim.v2_0.RoleService'
java_import 'org.kuali.rice.kim.v2_0.GroupService'
java_import 'org.kuali.rice.core.v2_0.StringMapEntryListType'
java_import 'org.kuali.rice.kim.v2_0.EntityType'
java_import 'org.kuali.rice.core.v2_0.ParameterKeyType'
java_import 'org.kuali.rice.location.v2_0.StateService'
java_import 'org.kuali.rice.location.v2_0.PostalCodeService'

cwd = File.symlink?(__FILE__) ? File.dirname(File.readlink(__FILE__)) : File.dirname(__FILE__)
Dir["#{cwd}/kuality-kfs/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/page_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/page_objects/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/page_objects/*/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/page_objects/*/*/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/data_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/data_objects/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/data_objects/*/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{cwd}/kuality-kfs/data_objects/*/*/*/*.rb"].alphabetize.each {|f| require f }

# Initialize this class at the start of your test cases to
# open the specified test browser at the specified welcome page URL.
#
# The initialization will
# create the browser object that can be used throughout the page classes
class KualityKFS

  attr_reader :browser

  def initialize(web_browser)
    @browser = Watir::Browser.new web_browser
    @browser.window.resize_to(1400,900)
    @browser.goto $base_url
  end

end