class RankingCell < Cell::Rails
  include MultiCommerce::CurrentFranchise

  def show
    @ranking = current_franchise.unities.ranking
    render
  end

end
