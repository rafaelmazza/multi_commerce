require 'spec_helper'

describe Franchise do
  it { should have_many :products }
  it { should have_many :unities }  
  it { should have_many :leads }
  it { should have_many :vouchers }
end