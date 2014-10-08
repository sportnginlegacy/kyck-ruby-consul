require 'spec_helper'

describe Consul::Client::Instantiator do
  describe '.instantiate' do
    %w(service node).each do |resource|
      it "calls .new_from_consul_data on #{resource} class" do
        expected_class = Consul::Core.const_get(resource.capitalize)
        expected_class.stub(:new_from_consul_data)
        expected_class.should_receive :new_from_consul_data
        subject.instantiate(resource, nil)
      end
    end
  end
end
