require 'spec_helper'

describe Consul::Core::Service do
  describe 'class methods' do
    subject(:klass)    { described_class }

    describe '.new_from_consul_data' do
      before(:each) do
        @services = klass.new_from_consul_data(services_data)
      end

      context 'data is an array' do
        let(:services_data) { response_for :service, 'web' }

        it 'returns an array of services' do
          @services.each do |service|
            service.should be_a klass
          end
        end
      end

      # consul does some weird stuff with this endpoint
      # TODO: fix Consul::Core::Service to return full objects possibly
      context 'data is a hash' do
        let(:services_data) { response_for :service }

        it 'returns an array of half initialized services' do
          @services.each do |service|
            service.should be_a klass
          end
        end
      end
    end
  end
end
