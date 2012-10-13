class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string :title
      t.string :description
    end
  end
end
