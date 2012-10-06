require 'spec_helper'

describe Product do
  it { should belong_to(:franchise) }
  it { should have_many :line_items }
end