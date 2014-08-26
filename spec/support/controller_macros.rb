module ControllerMacros
  def login_manager
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:user_manager)
    end
  end

  def login_unity
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:user_unity)
    end
  end
  
  def http_login
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', '12345678')
    end
  end
end