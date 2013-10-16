# encoding: utf-8
module MCollective
  class Application::Putfacts<Application
    description "Ping all nodes"

      def handle_message(action, message, *args)
        messages = {1 => 'Please specify a node to operate on'}
        send(action, messages[message] % args)
      end

    def post_option_parser(configuration)
      if ARGV.size < 1
        handle_message(:raise, 1)
      else
        configuration[:server] = ARGV.shift
      end
    end

    def main
#      require 'rubygems'
#      require 'json'
#      require 'puppet/network/http_pool'
#      require 'uri'
#      require 'puppet/util/puppetdb/char_encoding'
#      require 'digest'
      require 'yaml'
      require 'puppet'
      require 'puppet/node'
      require 'puppet/node/facts'

      pkg = rpcclient("facts")
      pkg.identity_filter configuration[:server]
      pkg_result = pkg.send('getfacts')

      pkg_result.each do |result|
       @facts = result[:data][:facts]
      end

      payload=Puppet::Node::Facts.new(configuration[:server],@facts)

      foo = `curl -o wtf.file --cert /etc/puppetlabs/puppet/ssl/certs/pe31.spence.org.uk.local.pem --key /etc/puppetlabs/puppet/ssl/private_keys/pe31.spence.org.uk.local.pem --cacert /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem -k -X PUT -H 'Content-Type: text/yaml' --data-binary '#{payload.to_yaml}' https://pe31.spence.org.uk.local:8140/production/facts/pe31.spence.org.uk.local`

    end
  end
end
