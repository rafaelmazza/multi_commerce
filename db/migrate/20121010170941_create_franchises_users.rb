class CreateFranchisesUsers < ActiveRecord::Migration
  def change
    create_table :franchises_users, id: false do |t|
      t.references :franchise
      t.references :user
    end
  end
end
