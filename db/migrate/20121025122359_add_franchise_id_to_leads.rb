class AddFranchiseIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :franchise_id, :integer
  end
end
