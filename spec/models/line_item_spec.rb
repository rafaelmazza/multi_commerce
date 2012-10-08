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
  
  it 'update voucher total after save' do
    line_item = build(:line_item)
    line_item.should_receive(:update_voucher)
    line_item.save
  end
  
  it 'update voucher total before destroy' do
    line_item = build(:line_item)
    line_item.should_receive(:update_voucher)
    line_item.destroy
  end
  
  describe '#total' do
    it 'returns line items total' do
      line_item = create(:line_item, product: create(:product, price: 10), quantity: 2)
      line_item.total.should == 20
    end
  end
end