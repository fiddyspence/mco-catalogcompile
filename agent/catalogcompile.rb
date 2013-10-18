module MCollective
  module Agent
    class Catalogcompile<RPC::Agent

      action "compile" do
        @config = Config.instance

        validate :server, String

        result = {:exitcode => nil,
                  :output => "",
        }

        cmd = Shell.new("/usr/bin/curl -s --cert #{@config.pluginconf['putfacts.cert']} --key #{@config.pluginconf['putfacts.key']} --cacert #{@config.pluginconf['putfacts.cacert']} -H 'Accept: pson' https://#{@config.pluginconf['putfacts.server']}:8140/production/catalog/#{request[:server]}", :stdout => result[:output], :stderr => result[:output])

       cmd.runcommand

       reply[:catalog] = result[:output]
      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
