class AddPhoneCodeToUnity < ActiveRecord::Migration
  def change
    add_column :unities, :phone_code, :string
  end
end
