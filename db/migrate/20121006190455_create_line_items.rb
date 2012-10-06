class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :voucher
      t.references :product
      
      t.decimal :price, precision: 8, scale: 2, null: false
      
      t.timestamps
    end
  end
end
