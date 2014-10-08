require 'spec_helper'

describe Consul::Client::UrlMapper do
  describe 'class methods' do
    subject(:mapper)  { described_class }
    let(:map)         { described_class::MAP }
    let(:random_name) { %w(wat randomness hello dlrow).sample }

    described_class::MAP.each do |method, endpoint|
      it "returns #{endpoint}s for #{method}" do
        mapper.send(method).should eq "#{endpoint}s"
      end

      it "returns #{endpoint}/<name> for #{method} with arg <name>" do
        mapper.send(method, random_name).should eq "#{endpoint}/#{random_name}"
      end
    end

    describe ".each" do
      context 'without a given block' do
        it 'returns an enumerator' do
          mapper.each.should be_a Enumerator
        end
      end

      context 'with a block given' do
        it 'returns an enumeratated version of MAP' do
          mapper.each do |k, v|
            map[k].should eq v
          end
        end
      end
    end
  end
end
