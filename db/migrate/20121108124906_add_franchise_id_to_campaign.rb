class AddFranchiseIdToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :franchise_id, :integer
  end
end
