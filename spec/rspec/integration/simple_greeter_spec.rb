require 'spec_helper'
require 'rspec/eth'
require 'pry'
RSpec.describe 'SimpleGreeter', type: :smart_contract do
  before do
    contract.deploy_and_wait
  end

  it 'sets greeting' do
    expect(contract.call.greet).to eq("Hello, World!")
  end

  it 'has owner' do
    expect(contract.call.owner).to be_present
    expect(contract.call.owner).to eq(accounts[0][2..-1])
  end

  it 'changes message' do
    contract.transact_and_wait.set_super_greeting("Yo")

    expect(contract.call.greet).to eq("Yo")
  end

  context 'when sender not owner' do
    before { contract.sender = accounts[1] }

    it 'trying to set not from owner' do
      expect {
        contract.transact_and_wait.set_super_greeting("Yo")
      }.to raise_exception(IOError, "VM Exception while processing transaction: revert Only owner")
    end
  end
end
