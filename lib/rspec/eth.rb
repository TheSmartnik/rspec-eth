require 'ethereum.rb'
require 'rspec/eth/version'
require 'rspec/eth/config'
require 'rspec/eth/rspec'

module RSpec
  module Eth
    def self.configure
      yield(Config)
    end
  end
end
