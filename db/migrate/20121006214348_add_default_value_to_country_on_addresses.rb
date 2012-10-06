class AddDefaultValueToCountryOnAddresses < ActiveRecord::Migration
  def change
    change_column :addresses, :country, :string, default: 'BRA'
  end
end
