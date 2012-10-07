require 'spec_helper'

describe LineItem do
  it { should belong_to :voucher }
  it { should belong_to :product }
  
  describe '#copy_price' do
    let(:product) { create(:product, price: 10) }
    let(:line_item) { build(:line_item, product: product) }

    it 'copies product price before validate' do
      line_item.should_receive(:copy_price)
      line_item.save
      line_item.price.should == 10
    end
    
    its(:quantity) { should == 1 }
  end
end