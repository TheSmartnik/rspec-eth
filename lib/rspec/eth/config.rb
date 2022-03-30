require 'tempfile'

module Rspec
  module Eth
    class Config
      class << self
        attr_writer :account_keys_path, :port, :host

        def account_keys_path
          @account_keys_path || accounts_tempfile.path
        end

        def port
          @port || 8545
        end

        def host
          @host || '127.0.0.1'
        end

        private

        def accounts_tempfile
          @accounts_tempfile ||= Tempfile.new('rspec-eth')
        end
      end
    end
  end
end
