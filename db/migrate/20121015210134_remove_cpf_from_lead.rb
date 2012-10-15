class RemoveCpfFromLead < ActiveRecord::Migration
  def up
    remove_column :leads, :cpf
  end

  def down
    add_column :leads, :cpf, :string
  end
end
