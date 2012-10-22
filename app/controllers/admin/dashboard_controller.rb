class Admin::DashboardController < Admin::ApplicationController
  skip_load_resource only: [:index]
  
  def index
    # @ranking = Unity.ranking(current_franchise)
  end
end