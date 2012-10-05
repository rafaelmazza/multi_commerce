class AddLeadIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :lead_id, :integer
  end
end
