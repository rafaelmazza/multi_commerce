class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :franchise
      
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false
    end
  end
end
