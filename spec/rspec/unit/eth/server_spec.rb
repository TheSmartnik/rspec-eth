require 'spec_helper'
require 'rspec/eth/config'
require 'rspec/eth/server'
require 'pry'

RSpec.describe Rspec::Eth::Server do
  subject(:server) { described_class }

  describe 'general behaviour' do
    describe 'start' do
      after { server.stop }

      it 'starts server' do
        expect { server.start }.to change { server.ganache_pid }.from(nil)

        expect(`ps aux | grep #{server.ganache_pid}`).to include("ganache-cli --quiet")
      end
    end

    it 'stops server' do
      server.start
      expect(`ps aux | grep #{server.ganache_pid}`).to include("ganache-cli --quiet")

      pid = server.ganache_pid

      expect { server.stop }.to change { server.ganache_pid }.to(nil)
      expect(`ps aux | grep #{pid}`).to_not include("ganache-cli --quiet")
    end
  end
end
