metadata    :name        => "Puppet facts agent",
            :description => "Get teh facts",
            :author      => "fiddyspence",
            :license     => "ASL2",
            :version     => "1.0",
            :url         => "https://github.com/fiddyspence/mco-catalogcompile",
            :timeout     => 180

  action "apply", :description => "apply a catalog" do
    display :always

        input :catalog,
              :prompt      => "catalog",
              :description => "catalog to apply",
              :type        => :string,
              :validation  => false,
              :maxlength   => 100000000000000,
              :optional    => false

        output :bingo,
               :description => "Did it work",
               :display_as  => "bingo"

  end

