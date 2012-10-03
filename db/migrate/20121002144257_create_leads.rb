class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone_code
      t.string :phone
      t.string :address_search
      t.float :latitude
      t.float :longitude
    end
  end
end
