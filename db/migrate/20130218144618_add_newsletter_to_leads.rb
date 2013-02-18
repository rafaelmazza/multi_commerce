class AddNewsletterToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :newsletter, :boolean, default: true, null: false
  end
end
