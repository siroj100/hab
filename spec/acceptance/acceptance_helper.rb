require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

#Capybara.default_driver = :selenium

Spec::Runner.configure do |config|
  config.include Capybara 
end

def login_as(user)
  visit '/login'
  fill_in 'login', :with => user.email_address
  fill_in 'password', :with => user.password
  click_button 'Log in'
end

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
