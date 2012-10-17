class Admin::DashboardController < Admin::ApplicationController
  skip_load_resource only: [:index]
  
  def index
  end
end