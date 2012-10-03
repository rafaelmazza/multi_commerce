class AddLatitudeAndLongitudeToUnity < ActiveRecord::Migration
  def change
    add_column :unities, :latitude, :float
    add_column :unities, :longitude, :float
  end
end
