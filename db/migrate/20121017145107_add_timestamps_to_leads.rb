class AddTimestampsToLeads < ActiveRecord::Migration
  def change
    change_table :leads do |t|
      t.timestamps
    end
  end
end
