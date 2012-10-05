class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :complement      
      t.string :number
      t.string :district
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
    end
  end
end
