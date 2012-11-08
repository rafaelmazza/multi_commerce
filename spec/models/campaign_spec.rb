require 'spec_helper'

describe Campaign do
  it { should have_many :leads }
  it { should belong_to :franchise }
end