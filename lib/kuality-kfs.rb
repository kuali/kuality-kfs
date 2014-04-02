require 'test-factory'
#require 'jeweler'

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
    unless (env_no = ENV['TEST_ENV_NUMBER'].to_i).zero?
      # As described in the readme
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['webdriver.firefox.port'] = (8888 + env_no);
      @browser = Watir::Browser.new web_browser, :profile => profile

      # Enforces a sleep time, i need to multiply by 10 to achieve consistent results on
      # my 8 cores vm, may work for less though.
      sleep env_no * 10
    else
      @browser = Watir::Browser.new web_browser
    end

    @browser.window.resize_to(1400,900)
    @browser.goto $base_url
  end

end