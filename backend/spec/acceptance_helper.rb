require 'rails_helper'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.api_name = 'TravelPlanner'
  config.curl_host = 'localhost:3000'
end
