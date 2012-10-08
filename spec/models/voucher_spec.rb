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
  
  # describe '#total' do
  #   let(:product) { create(:product, price: 10) }
  #   let(:line_items) { [create(:line_item, product: product)] }
  #   
  #   it 'sum line items amount as total' do
  #     subject.line_items = line_items
  #     subject.total.should == 10
  #   end
  # end
  
  describe '#add_product' do
    let(:product) { create(:product) }
    
    it 'adds product line item to voucher' do
      line_item = subject.add_product(product)
      line_item.product.should == product
    end
    
    # it 'increments product line item quantity when added same product' do
    #   line_item = create(:line_item, product: product)
    #   voucher = create(:voucher, line_items: [line_item])
    #   expect { voucher.add_product(product) }.to change(line_item, :quantity).by(1)
    # end
    
    it 'sets default product quantity to 1 when not set' do
      voucher = create(:voucher)  
      line_item = voucher.add_product(product)    
      line_item.quantity.should == 1
    end
  end
  
  describe '#contains?' do
    let(:product) { create(:product) }
    
    it 'returns product line item if product had already been added on voucher' do
      line_item = create(:line_item, product: product)
      voucher = create(:voucher, line_items: [line_item])
      voucher.contains?(product).should be_true
    end
  end
  
  describe '#update!' do
    it 'updates voucher total' do
      line_items = 3.times.map { create(:line_item, product: create(:product, price: 10)) }
      voucher = create(:voucher, line_items: line_items)
      voucher.update!
      voucher.total.should == 30.0
    end
  end
end