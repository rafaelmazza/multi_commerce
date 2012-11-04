class AddTitleOnFranchise < ActiveRecord::Migration
  def change
    add_column :franchises, :title, :string
  end
end
