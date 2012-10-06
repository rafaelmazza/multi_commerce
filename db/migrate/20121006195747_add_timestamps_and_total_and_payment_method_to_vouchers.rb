class AddTimestampsAndTotalAndPaymentMethodToVouchers < ActiveRecord::Migration
  def up
    add_column :vouchers, :total, :decimal, precision: 8, scale: 2
    add_column :vouchers, :payment_method, :string
    
    change_table :vouchers do |t|
      t.timestamps
    end
  end
  
  def down
    remove_column :vouchers, :total
    remove_column :vouchers, :payment_method
    remove_column :vouchers, :created_at
    remove_column :vouchers, :updated_at
  end
end

