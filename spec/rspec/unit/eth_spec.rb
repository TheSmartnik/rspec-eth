require 'spec_helper'
require 'rspec/eth/config'

RSpec.describe RSpec::Eth do
  describe 'configure' do
    { port: 8000, host: '8.8.8.8', account_keys_path: '.something', contracts_path: 'smart_contracts' }.each do |option, expectation|
      it "sets #{option}" do
        described_class.configure do |config|
          config.public_send("#{option}=", expectation)
        end

        expect(RSpec::Eth::Config.public_send(option)).to eq(expectation)
      end
    end
  end
end
