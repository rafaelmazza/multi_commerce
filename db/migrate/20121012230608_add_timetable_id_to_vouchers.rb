class AddTimetableIdToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :timetable_id, :integer
  end
end
