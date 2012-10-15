class AddStatusToVoucher < ActiveRecord::Migration
  def change
    add_column :vouchers, :status, :string
  end
end
