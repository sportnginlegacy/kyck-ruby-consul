module Consul
  class Client
    module UrlMapper

      MAP = {
        service: '/v1/catalog/service',
        node:    '/v1/catalog/node'
      }

      class << self
        MAP.each do |resource, endpoint|
          define_method resource do |name = nil|
            name.nil? ? "#{endpoint}s" : "#{endpoint}/#{name}"
          end
          alias_method :"url_for_#{resource}", resource
        end

        def each
          return MAP.to_enum(:each) unless block_given?
          MAP.each do |resource, endpoint|
            yield resource, endpoint
          end
        end
      end
    end
  end
end

