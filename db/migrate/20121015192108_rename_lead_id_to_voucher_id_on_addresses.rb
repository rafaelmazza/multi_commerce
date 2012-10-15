class RenameLeadIdToVoucherIdOnAddresses < ActiveRecord::Migration
  def up
    rename_column :addresses, :lead_id, :voucher_id
  end

  def down
    rename_column :addresses, :voucher_id, :lead_id
  end
end
