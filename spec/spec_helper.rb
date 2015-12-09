ENV["RACK_ENV"] ||= "test"
require 'rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'launchy'

require_relative '../app.rb'
require_relative '../app/models/user'
require_relative '../app/models/meetup'
require_relative '../app/models/comment'
require_relative '../app/models/membership'
require_relative '../spec/features/seeder_module'

Dir[__dir__ + '/support/*.rb'].each { |file| require_relative file }

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.before :each do
    OmniAuth.config.mock_auth[:github] = nil
  end
  OmniAuth.config.test_mode = true
  config.include AuthenticationHelper
end
