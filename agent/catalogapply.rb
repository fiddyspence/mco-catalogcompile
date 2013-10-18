module MCollective
  module Agent
    class Catalogapply<RPC::Agent

      action "apply" do
    
result = {:exitcode => nil,
                 :output => "",
       }
       File.open('/tmp/foocatalog','w') { |f| f.write request[:catalog] ; f.flush }
       cmd = Shell.new("/opt/puppet/bin/puppet apply --catalog /tmp/foocatalog", :stdout => result[:output], :stderr => result[:output])
       cmd.runcommand
       result[:exitcode] = cmd.status.exitstatus
       reply[:status] = result[:exitcode]
       reply[:bingo] = result[:output]
#       File.unlink('/tmp/foocatalog','w')
      end
    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
