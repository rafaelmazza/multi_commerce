class AddQueryStringToLead < ActiveRecord::Migration
  def change
    add_column :leads, :query_string, :string, default: nil
  end
end
