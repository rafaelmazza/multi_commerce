class AddedAkatusFieldsToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :transaction_key, :string, default: nil
    add_column :vouchers, :payment_url, :string, default: nil
  end
end
