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
  
  describe '#total' do
    let(:product) { create(:product, price: 10) }
    let(:line_items) { [create(:line_item, product: product)] }
    
    it 'sum line items amount as total' do
      subject.line_items = line_items
      subject.total.should == 10
    end
  end
end