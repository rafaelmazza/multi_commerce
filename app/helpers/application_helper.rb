module ApplicationHelper
  def merge_search_params(new_params, excluding_keys=[])
    if params[:q]
      excluding_keys.each do |key|
        params[:q].delete(key)
      end
      return {q: params[:q].merge(new_params)}.merge(active: new_params)
    end
    {q: new_params}.merge(active: new_params)
  end
end
