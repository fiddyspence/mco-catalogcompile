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
      @config = Config.instance
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

      foo = `curl -o wtf.file --cert #{@config.pluginconf['putfacts.cert']} --key #{@config.pluginconf['putfacts.key']} --cacert #{@config.pluginconf['putfacts.cacert']} -k -X PUT -H 'Content-Type: text/yaml' --data-binary '#{payload.to_yaml}' https://#{@config.pluginconf['putfacts.server']}:8140/production/facts/#{configuration[:server]}`

    end
  end
end
