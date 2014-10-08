require 'consul/core'

module Consul
  class Client
    module Instantiator
      class << self
        def instantiate(resource, data)
          klass = klass_for(resource)
          klass.new_from_consul_data(data)
        end

        private

        def klass_for(resource)
          Consul::Core.const_get(resource.capitalize)
        end
      end
    end
  end
end
