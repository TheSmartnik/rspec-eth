require 'tempfile'

module RSpec
  module Eth
    class Config
      class << self
        attr_writer :account_keys_path, :port, :host, :contracts_path

        def account_keys_path
          @account_keys_path || accounts_tempfile.path
        end

        def port
          @port || 8545
        end

        def host
          @host || '127.0.0.1'
        end

        def contracts_path
          @contracts_path || 'contracts'
        end

        private

        def accounts_tempfile
          @accounts_tempfile ||= Tempfile.new('rspec-eth')
        end
      end
    end
  end
end
