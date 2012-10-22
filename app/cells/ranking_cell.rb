class RankingCell < Cell::Rails
  include MultiCommerce::CurrentFranchise

  def show
    @ranking = Unity.ranking(current_franchise)
    render
  end

end
