Dir['./lib/**/*.rb'].each {|file| require file }

require 'rspec/collection_matchers'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.raise_errors_for_deprecations!
end