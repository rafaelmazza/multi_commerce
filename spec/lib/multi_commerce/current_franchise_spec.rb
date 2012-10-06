require 'spec_helper'

describe MultiCommerce::CurrentFranchise do
  include MultiCommerce::CurrentFranchise

  # mock request
  def request
    mock(:server_name => "desconto.wizard.dev.br")
  end
  
  describe '.current_franchise' do
    before do
      create(:franchise, name: 'wizard', url: 'desconto.wizard.dev.br')
    end
    
    it 'returns franchise based on current url' do
      current_franchise.name.should == 'wizard'
    end
  end
end