require 'spec_helper'

describe Franchise do
  it { should have_many :products }
  it { should have_many :unities }  
end