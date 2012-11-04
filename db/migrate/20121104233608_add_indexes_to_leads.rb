class AddIndexesToLeads < ActiveRecord::Migration
  def change
    add_index :leads, :id, :unique => true
    add_index :leads, :email
    add_index :leads, :created_at
    add_index :leads, :prospected_at
    add_index :leads, :enrolled_at
  end
end
