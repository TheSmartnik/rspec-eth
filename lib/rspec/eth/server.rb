module RSpec
  module Eth
    class Server
      class << self
        attr_accessor :ganache_pid, :ganache_read_output

        def start(wait_until_ready: true)
          if !ganache_pid
            self.ganache_read_output, ganache_write_output = IO.pipe
            options = ["--quiet", "--account_keys_path #{Config.account_keys_path}", "-p #{Config.port}", "-h #{Config.host}"]
            self.ganache_pid = Process.spawn("ganache-cli #{options.join(" ")}", out: ganache_write_output, err: STDOUT)

            # Enough to understand that that server is ready
            ganache_read_output.read(60) if wait_until_ready
          else
            warn("Server already runnin")
          end
        end

        def stop
          if ganache_pid
            Process.kill("TERM", ganache_pid)
            self.ganache_pid = nil
            self.ganache_read_output = nil
          else
            warn("Server isn't running")
          end
        end

        def restart
          start
          stop
        end
      end
    end
  end
end
