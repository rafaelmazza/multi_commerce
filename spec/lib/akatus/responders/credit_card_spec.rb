# encoding: UTF-8
require 'spec_helper'

describe Akatus::Responders::CreditCard do
  # let(:voucher) { mock(:voucher).as_null_object }
  let(:voucher) { create(:voucher) }
  
  context 'on error' do
    let(:response) { mock(:response, body: File.read(Rails.root.join('spec', 'support', 'fixtures', 'payment_error.xml'))) }
    
    describe '.process' do
      it 'returns payment with parsed data' do
        payment = described_class.process(voucher, response)
        payment.status.should == 'erro'
        payment.description.should == 'descrição do erro'
      end
      
      it 'creates a payment' do
        expect { described_class.process(voucher, response) }.to change(Akatus::Payment, :count).by(1)
      end
      
      it 'belongs to voucher' do
        payment = described_class.process(voucher, response)
        payment.voucher.should == voucher
      end
    end
  end
  
  context 'on success' do
    let(:response) { mock(:response, body: File.read(Rails.root.join('spec', 'support', 'fixtures', 'creditcard_payment_success.xml'))) }
    
    describe '.process' do
      it 'returns payment with parsed data' do
        payment = described_class.process(voucher, response)
        payment.status.should == 'Em Análise'
        payment.akatus_transaction.should == '1f5cbb15-9695-4947-9154-19d6b08cf816'
      end
      
      it 'creates a payment' do
        expect { described_class.process(voucher, response) }.to change(Akatus::Payment, :count).by(1)
      end
    end
  end
end