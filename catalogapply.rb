module MCollective
  module Agent
    class Catalogapply<RPC::Agent

      action "apply" do
      foo = File.open('/tmp/thelog','w')
       require 'puppet'
       require 'puppet/application'
       require 'puppet/configurer'
       ::Puppet.settings.preferred_run_mode = :agent
        unless ::Puppet.settings.app_defaults_initialized?
          ::Puppet.settings.initialize_app_defaults(::Puppet::Settings.app_defaults_for_run_mode(::Puppet.run_mode))
        end

      foo.write "here\n"
      foo.flush  
      begin
        catalog = ::Puppet::Resource::Catalog.convert_from(::Puppet::Resource::Catalog.default_format,request[:catalog])
        catalog = ::Puppet::Resource::Catalog.pson_create(catalog) unless catalog.is_a?(::Puppet::Resource::Catalog)
      rescue => detail
         foo.write "fucking error tard\n"
  
        raise ::Puppet::Error, "Could not deserialize catalog from pson: #{detail}"
      end
  
      foo.write "here too\n"
      foo.flush  
      configurer = ::Puppet::Configurer.new
      foo.write "#{configurer.inspect}\n"
      foo.write Time.now.to_s
      foo.flush  
      foo.write "now fucking here fuck you fucker\n"
      foo.flush  
      final_catalog = catalog.to_ral
      final_catalog.finalize
      tard = configurer.run(:catalog => final_catalog, :pluginsync => false)
      foo.write Time.now.to_s
      foo.flush  
      foo.write "and the result we got back was: #{tard.inspect}\n"
      foo.flush  
      foo.write "\n\n we got iright to the fucking end here\n\n"
      foo.flush  
      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
