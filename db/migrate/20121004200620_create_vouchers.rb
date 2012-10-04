class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.references :unity
      t.references :lead
      
      t.string :code
      t.datetime :used_at
    end
  end
end
