# encoding: utf-8
module MCollective
  class Application::Getcatalog<Application
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
      catalog = rpcclient("catalogcompile")

      catalog.identity_filter @config.pluginconf['putfacts.server']
      catalog_result = catalog.compile(:server => configuration[:server])

      catalog_result.each do |result|
        @catalog = result[:data][:catalog]
      end

      File.open('/tmp/catalog','w') { |f| f.write @catalog }
      puts 'right you fucks'

      applyer = rpcclient("catalogapply")
      applyer.identity_filter configuration[:server]
      applyer_result = applyer.apply(:catalog => @catalog)
      puts applyer_result.inspect

    end
  end
end
