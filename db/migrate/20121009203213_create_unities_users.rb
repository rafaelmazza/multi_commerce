class CreateUnitiesUsers < ActiveRecord::Migration
  def change
    create_table :unities_users, id: false do |t|
      t.references :unity
      t.references :user
    end
  end
end
