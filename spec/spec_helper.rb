GEM_ROOT = File.expand_path("../../", __FILE__)
$:.unshift File.join(GEM_ROOT, "lib")

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
end

require 'rspec'
require 'pry'
require 'json'
require 'consul'

Dir[File.join(GEM_ROOT, "spec", "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
end

def response_for(resource, name = nil)
  fileparts = %w(get)
  if name.nil?
    fileparts << "#{resource}s"
  else
    fileparts << resource
    fileparts << name
  end
  fileparts << "response.json"
  filename = File.expand_path("examples/#{fileparts.join("_")}", GEM_ROOT)
  JSON.parse(File.read(filename))
end
