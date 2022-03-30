require 'json'

module RSpec
  module Eth
    module HelperMethods
      def client
        @client ||= begin
          Ethereum::HttpClient.new("http://#{RSpec::Eth::Config.host}:#{RSpec::Eth::Config.port}")
        end
      end

      def contract
        @contract ||= begin
          Ethereum::Contract.create(file: contract_path, client: client)
        end
      end

      def accounts
        @accounts ||= begin
          accounts_data = File.read(RSpec::Eth::Config.account_keys_path)
          JSON.parse(accounts_data)['addresses'].keys
        end
      end

      def contract_path
        @contract_path ||= begin
          filename = self.class.metadata[:file_path].split('/').last.gsub('_spec', '').gsub('.rb', '')
          File.join(RSpec::Eth::Config.contracts_path, "#{filename}.sol")
        end
      end
    end
  end
end
