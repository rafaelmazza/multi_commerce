require 'spec_helper'

describe Franchise do
  it { should have_many(:products) }
end