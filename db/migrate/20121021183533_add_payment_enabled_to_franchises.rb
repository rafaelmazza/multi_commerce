class AddPaymentEnabledToFranchises < ActiveRecord::Migration
  def change
    add_column :franchises, :payment_enabled, :boolean, default: false
  end
end
