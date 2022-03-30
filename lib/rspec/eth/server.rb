module Rspec
  module Eth
    class Server
      class << self
        attr_accessor :ganache_pid

        def start
          if !ganache_pid
            options = ["--quiet", "--account_keys_path #{Config.account_keys_path}", "-p #{Config.port}", "-h #{Config.host}"]
            self.ganache_pid = Process.spawn("ganache-cli #{options.join(" ")}", out: "/dev/null", err: STDOUT)
          else
            warn("Server already runnin")
          end
        end

        def stop
          if ganache_pid
            Process.kill("TERM", ganache_pid)
            self.ganache_pid = nil
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
