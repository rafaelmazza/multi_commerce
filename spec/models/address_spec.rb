require 'spec_helper'

describe Address do
  it { should validate_presence_of :zipcode }
  # it { should validate_format_of(:zipcode).with(/^\d{5}-?\d{3}$/) }
  
  it { should validate_presence_of :street }
  it { should validate_presence_of :number }
  it { should validate_presence_of :district }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
end