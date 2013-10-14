module MCollective
  module Agent
    class Facts<RPC::Agent
      metadata :name        => "Puppet facts agent",
               :description => "Get facts",
               :author      => "fiddyspence",
               :license     => "ASL2",
               :version     => "1.0",
               :url         => "https://github.com/fiddyspence/mco-catalogcompile",
               :timeout     => 180

      action "getfacts" do
        require 'puppet'
        require 'facter'
        unless ::Puppet.settings.app_defaults_initialized?
          ::Puppet.parse_config
        end
  
        unless $LOAD_PATH.include?(::Puppet[:libdir])
          $LOAD_PATH << ::Puppet[:libdir]
        end
        reply[:facts] = ::Facter.to_hash
      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
