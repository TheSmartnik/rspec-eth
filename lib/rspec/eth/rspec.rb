require 'rspec/core'
require 'rspec/eth/helper_methods'
require 'rspec/eth/server'

RSpec.configure do |config|
  config.include RSpec::Eth::HelperMethods, type: :smart_contract

  config.after(:all) do |_example|
    if self.class.include?(RSpec::Eth::HelperMethods)
      RSpec::Eth::Server.stop
    end
  end

  config.before(:all) do |_example|
    if self.class.include?(RSpec::Eth::HelperMethods)
      RSpec::Eth::Server.start
    end
  end
end
