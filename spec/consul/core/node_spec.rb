require 'spec_helper'
require 'pry'

describe Consul::Core::Node do
  describe 'class methods' do
    subject(:klass) { described_class }
    let(:node_data) { {'Node' => 'A node', 'Address' => 'An address'} }

    describe '#new' do
      it 'sets name attr from the Node key' do
        node = klass.new(node_data)
        node.name.should be node_data['Node']
      end

      it "sets the address from the 'Address' key" do
        node = klass.new(node_data)
        node.address.should be node_data['Address']
      end
    end

    describe '#new_from_consul_data' do
      context 'arguement is an array' do
        let(:nodes_data) { 1.upto(3).map { node_data } }

        it 'returns an array of node objects' do
          nodes = klass.new_from_consul_data(nodes_data)
          nodes.each do |node|
            node.should be_a klass
          end
        end
      end

      context 'arguement is a hash' do
        it 'returns a single node object' do
          node = klass.new_from_consul_data(node_data)
          node.should be_a klass
        end
      end

      context 'arguement is node data nested under a node data key' do
        let(:nested_data) { { 'Node' => node_data } }

        it 'returns a node object' do
          node = klass.new_from_consul_data(nested_data)
          node.should be_a klass
        end
      end
    end
  end
end
