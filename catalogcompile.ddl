metadata    :name        => "Puppet catalog agent",
            :description => "Ask a puppetmaster to compile a catalog via mcollective",
            :author      => "fiddyspence",
            :license     => "ASL2",
            :version     => "1.0",
            :url         => "https://github.com/fiddyspence/mco-catalogcompile",
            :timeout     => 180

  action "compile", :description => "compile a catalog" do
    display :always
    input :server,
            :prompt      => "Name of the node to compile a catalog for",
            :description => "Which managed node we are compiling a catalog for",
            :type        => :string,
            :validation  => '.',
            :optional    => false,
            :maxlength   => 255

        output :catalog,
               :description => "The catalog",
               :display_as  => "Catalog"

        output :time,
               :description => "Catalog compile duration",
               :display_as  => "Time"

  end

