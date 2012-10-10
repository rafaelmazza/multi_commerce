class AddFranchiseIdToUnity < ActiveRecord::Migration
  def change
    add_column :unities, :franchise_id, :integer
  end
end
