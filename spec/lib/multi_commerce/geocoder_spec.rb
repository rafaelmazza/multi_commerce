require 'spec_helper'

describe MultiCommerce::Geocoder do
  describe '.perform' do
    it "should geocode all unities not geocoded" do
      unity = mock
      Unity.stub(:not_geocoded).and_return [unity]
      unity.should_receive :geocode
      unity.should_receive :save

      described_class.perform
    end    
  end
end