class AddCpfToVoucher < ActiveRecord::Migration
  def change
    add_column :vouchers, :cpf, :string
  end
end
