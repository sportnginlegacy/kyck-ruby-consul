require 'consul/core/node'

module Consul
  module Core
    class Service
      class << self
        def new_from_consul_data(data)
          if data.is_a? Array
            data.reduce([]) do |memo, d|
              memo << new(d)
            end
          elsif data.is_a? Hash
            data.reduce([]) do |memo, d|
              memo << allocate.instance_eval do
                # d is an array of one k,v pair from the data hash
                @name = d[0]
                @tags = d[1]
                self
              end
            end
          end
        end
      end

      attr_reader :node, :id, :name, :tags, :port

      def initialize(data)
        @node = Node.new(data)
        @id   = data['ServiceID']
        @name = data['ServiceName']
        @tags = data['ServiceTags']
        @port = data['ServicePort']
      end
    end
  end
end
