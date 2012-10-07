class AddCpfToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :cpf, :string
  end
end
