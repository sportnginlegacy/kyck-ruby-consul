require 'spec_helper'
require 'ostruct'
require 'pry'

describe Consul do
  describe 'class methods' do
    subject(:klass)    { described_class }
    let(:client_class) { klass::Client }
    before do
      klass.instance_variable_set :"@configuration", nil
      klass.instance_variable_set :"@client", nil
    end

    describe '.configure' do
      it 'stores values assigned in configure block' do
        klass.configure do |c|
          c.some_value = "some value"
        end
        klass.configuration.some_value.should eq "some value"
      end
    end

    describe '.client' do
      let(:config) { OpenStruct.new.custom = "yes" }
      
      it 'creates a new client' do
        client_class.should receive :new
        klass.client
      end

      it 'passes the configuration to the client' do
        client_class.should receive(:new).with(config)
        klass.instance_variable_set :"@configuration", config
        klass.client
      end

      it 'memoizes the client' do
        client = klass.client
        client.should eq klass.client
      end
    end
  end
end

