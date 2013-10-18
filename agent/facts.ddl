metadata    :name        => "Puppet facts agent",
            :description => "Get teh facts",
            :author      => "fiddyspence",
            :license     => "ASL2",
            :version     => "1.0",
            :url         => "https://github.com/fiddyspence/mco-catalogcompile",
            :timeout     => 180

  action "getfacts", :description => "compile a catalog" do
    display :always

        output :facts,
               :description => "The facts",
               :display_as  => "Facts"

  end

