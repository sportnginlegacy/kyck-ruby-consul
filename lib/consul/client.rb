require 'logger'
require 'faraday_middleware'
require 'consul/client/url_mapper'
require 'consul/client/instantiator'

module Consul
  class Client
    LOCALHOST        = '127.0.0.1'
    DEFAULT_PORT     = 8500
    DEFAULT_PROTOCOL = 'http'

    attr_reader :host, :port, :protocol, :conn

    def initialize(options = {})
      @host     = options[:host]      || LOCALHOST
      @port     = options[:port]      || DEFAULT_PORT
      @protocol = options[:protocol]  || DEFAULT_PROTOCOL
      set_logger(options[:logger])
    end

    def conn
      @conn ||= Faraday.new url do |connection|
        connection.request  :json
        connection.response :json, content_type: /\bjson$/
        connection.adapter  Faraday.default_adapter
      end
    end

    UrlMapper.each do |resource, endpoint|
      define_method resource do |name|
        get_resource resource: resource, endpoint: endpoint, name: name
      end

      define_method "#{resource}s" do
        get_resource resource: resource, endpoint: endpoint
      end
    end

    private

    def logger
      @logger
    end

    def set_logger(logger)
      @logger = if logger
        logger
      elsif Object.const_defined? "Rails"
        Rails.logger
      else
        Logger.new(STDOUT)
      end
    end

    def get_resource(options)
      res = conn.get UrlMapper.send(options[:resource], options[:name])
      if res.success?
        instantiate_obj(options[:resource], res.body)
      else
        logger.error("Cannot get #{options[:resource]}. Consul HTTP status: #{res.status}")
      end
    end

    def instantiate_obj(resource, data)
      Instantiator.instantiate(resource, data)
    end

    def url
      @url ||= "#{protocol}://#{host}:#{port}"
    end
  end
end
