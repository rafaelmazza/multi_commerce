class SplitAddressFieldsOnUnity < ActiveRecord::Migration
  def change
    remove_column :unities, :address
    add_column :unities, :address_street, :string
    add_column :unities, :address_number, :string
    add_column :unities, :address_district, :string
    add_column :unities, :address_zipcode, :string
    add_column :unities, :address_city, :string
    add_column :unities, :address_state, :string
  end
end
