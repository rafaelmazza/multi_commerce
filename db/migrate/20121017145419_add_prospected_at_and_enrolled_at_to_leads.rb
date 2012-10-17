class AddProspectedAtAndEnrolledAtToLeads < ActiveRecord::Migration
  def change
    change_table :leads do |t|
      t.datetime :prospected_at
      t.datetime :enrolled_at
    end
  end
end
