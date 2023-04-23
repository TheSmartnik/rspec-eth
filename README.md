# RSpec::Eth

RSpec extension that allows to easily test solidity smart contracts.

## What it does

* Spins up ganache server for tests
* Adds a few handy methods to ease testing of solidity contracts in ruby main ones:
    1. `contract` to access contract
    2. `accounts` to access addresses used by ganache

It's build on top of [etherium.rb](https://github.com/EthWorks/ethereum.rb). For documentation on how to interact with etherium blockchain please refer to its documentation

## Example Usage
Given a simple [Greeter contract](https://github.com/TheSmartnik/rspec-eth/blob/master/contracts/simple_greeter.sol). Here is an example of basic spec

```ruby
RSpec.describe 'SimpleGreeter', type: :smart_contract do
  before { contract.deploy_and_wait }

  it 'sets greeting' do
    expect(contract.call.greet).to eq("Hello, World!")
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
```

## Installation

### Prerequisite

1. Install ganache-cli
```
npm install -g ganache-cli
```
2. [Install solidity compilier](https://docs.soliditylang.org/en/v0.8.9/installing-solidity.html)
```
brew install solidity
```

3. Add gem to a Gemfile
Add this line to your application's Gemfile:

```ruby
gem 'rspec-eth'
```

4. Require extension in `spec_helper.rb` or `rails_helper.rb`
```
require 'rspec/eth'
```

## Configuration

`RSpec::Eth` provides a few configuration option that you probably won't need

```ruby
# spec_helper.rb

RSpec::Eth.configure do |config|
  config.account_keys_path = temp_path # Path for accounts created
  config.host = '127.0.0.1' # Host of ganache server
  config.port = '8545' # Port of ganache server
  config.contracts_path = 'contracts'# Set paths for your contracts
end

```


## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rspec` to run the tests.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TheSmartnik/rspec-eth.

