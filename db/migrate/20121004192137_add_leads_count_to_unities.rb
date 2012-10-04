class AddLeadsCountToUnities < ActiveRecord::Migration
  def change
    add_column :unities, :leads_count, :integer, default: 0
  end
end
