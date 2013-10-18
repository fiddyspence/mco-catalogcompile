module MCollective
  module Agent
    class Facts<RPC::Agent

      action "getfacts" do
        require 'puppet'
        require 'facter'
        unless ::Puppet.settings.app_defaults_initialized?
          ::Puppet.parse_config
        end
  
        unless $LOAD_PATH.include?(::Puppet[:libdir])
          $LOAD_PATH << ::Puppet[:libdir]
        end
        ::Facter.clear
        reply[:facts] = ::Facter.to_hash
      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
