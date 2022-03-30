require 'spec_helper'
require 'rspec/eth/config'

RSpec.describe RSpec::Eth::Config do
  subject(:config) { described_class }

  describe 'default options' do
    its(:port) { is_expected.to eq(8545) }
    its(:host) { is_expected.to eq('127.0.0.1') }
    its(:contracts_path) { is_expected.to eq('contracts') }
    it { expect(File.exists?(config.account_keys_path)).to eq(true) }
  end

  describe 'write' do
    { port: 8000, host: '8.8.8.8', account_keys_path: '.something', contracts_path: 'smart_contracts' }.each do |option, expectation|
      it "sets #{option} correctly" do
        config.public_send("#{option}=", expectation)
        expect(config.public_send(option)).to eq(expectation)
      end
    end
  end
end
