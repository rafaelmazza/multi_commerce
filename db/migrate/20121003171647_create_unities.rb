class CreateUnities < ActiveRecord::Migration
  def change
    create_table :unities do |t|
      t.string :code
      t.string :name
      t.string :status
      t.string :situation
      t.string :franchise_acronym
      t.string :email
      t.string :phone
      t.string :address
      # t.string :number
      # t.string :district
      # t.string :city
      # t.string :state
      # t.string :country
      # t.string :zipcode
    end
  end
end
