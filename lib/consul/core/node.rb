module Consul
  module Core
    class Node
      class << self
        def new_from_consul_data(data)
          if data.is_a? Array
            data.map { |d| self.new(d) }
          else
            self.new(data)
          end
        end
      end

      attr_reader :name, :address

      def initialize(data)
        node_data = get_node_obj(data)
        @name     = node_data['Node']
        @address  = node_data['Address']
      end

      private

      # recursion FTW
      # For some crazy reason consul returns a key "Node" which's value is a
      # single json object with a key of "Node" and "Address".
      # This gets down to the real node object.
      def get_node_obj(data)
        if data['Address']
          data
        else
          get_node_obj data['Node']
        end
      end
    end
  end
end
