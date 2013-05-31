require 'puppet'
require 'puppet/face'

module MCollective
  module Agent
    class Catalogcompile<RPC::Agent
      metadata :name        => "Puppet catalog agent",
               :description => "Ask a puppetmaster to compile a catalog via mcollective",
               :author      => "fiddyspence",
               :license     => "ASL2",
               :version     => "1.0",
               :url         => "https://github.com/fiddyspence/mco-catalogcompile",
               :timeout     => 180

      action "compile" do
        validate :server, String

        facts=Puppet::Face[:facts, :current].find(request[:server])
        node=Puppet::Node.new(request[:server])
        node.merge(facts.values)
        t = Time.now.to_f
        catalog=Puppet::Resource::Catalog.indirection.find(request[:server], :node => node)
        u = Time.now.to_f
        reply[:catalog] = catalog.to_pson
        reply[:time] = u-t

      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby