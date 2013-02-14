module MultiCommerce
  module CurrentFranchise
    # extend ActiveSupport::Concern
    
    def current_franchise
      # @current_franchise ||= Franchise.find_by_url(request.server_name)
      @current_franchise ||= Franchise.find_by_name('wizard')
    end
        
    def self.included m
      return unless m < ActionController::Base
      m.helper_method :current_franchise
    end
  end
end