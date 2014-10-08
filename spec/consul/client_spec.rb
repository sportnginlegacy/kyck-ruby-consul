require 'spec_helper'

describe Consul::Client do
  subject(:client) { described_class.new }
  before { client.instance_variable_set :"@conn", nil }

  describe '#new' do
    %w(host port protocol).each do |attr|
      it "sets the #{attr}" do
        value = 'some value'
        client = described_class.new attr.to_sym => value
        client.send(attr).should eq value
      end
    end
  end

  describe '#conn' do
    it 'creates a new Faraday connection' do
      Faraday.should receive :new
      client.conn
    end
  end

  describe 'dynamic methods' do
    it 'responds to UrlMapper keys' do
      described_class::UrlMapper.each do |method, _|
        client.should respond_to method
      end
    end

    it 'responds to UrlMapper pluarlized keys' do
      described_class::UrlMapper.each do |method, _|
        client.should respond_to "#{method}s"
      end
    end
  end
end
