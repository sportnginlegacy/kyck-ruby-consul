require 'ostruct'
require 'faraday_middleware'
require 'consul/core'
require 'consul/client'
require 'consul/version'

module Consul
  class << self

    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield configuration
    end

    def client
      @client ||= Client.new configuration
    end
  end
end
