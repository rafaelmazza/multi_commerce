module MultiCommerce
  module CurrentFranchise
    
    def current_franchise
      @current_franchise ||= Franchise.find_by_url(request.server_name)
    end
    
  end
end