class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :voucher
      
      t.string :status
      t.string :description
      t.string :akatus_transaction
      t.string :url
      
      t.timestamps
    end
  end
end
