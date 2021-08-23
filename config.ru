# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'
Capybara.asset_host = 'http://localhost:3000'
CAPYBARA_WINDOW_SIZE = [1366, 768].freeze
Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("headless")
  options.add_argument("window-size=#{CAPYBARA_WINDOW_SIZE.join(',')}")
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end
Capybara.javascript_driver = :chrome
Capybara.ignore_hidden_elements = false
Capybara.save_path = "spec/screenshots"
Capybara::Screenshot.autosave_on_failure = false

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run
# From https://github.com/mattheworiordan/capybara-screenshot/issues/84#issuecomment-41219326
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
