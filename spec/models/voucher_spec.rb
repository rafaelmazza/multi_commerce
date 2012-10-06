require 'spec_helper'

describe Voucher do
  it { should belong_to :unity }
  it { should belong_to :lead }
  it { should have_many :line_items }
  
  it 'generates code when created' do
    MultiCommerce::VoucherGenerator.stub(:generate).and_return "code"
    
    voucher = Voucher.new
    voucher.save
    voucher.code.should == 'code'
  end
  
  describe '#use' do
    let(:time_now) { Time.now }
    
    before do
      Time.stub :now => time_now
    end
    
    it 'saves timestamp on used at field' do
      subject.use
      subject.used_at.should == time_now
    end
  end
end