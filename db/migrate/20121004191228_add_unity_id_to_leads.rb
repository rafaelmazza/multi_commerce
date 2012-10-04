class AddUnityIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :unity_id, :integer
  end
end
