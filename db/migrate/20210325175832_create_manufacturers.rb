class CreateManufacturers < ActiveRecord::Migration[6.1]
  def change
    create_table :manufacturers do |t|
      t.string :name, null: false
      t.string :cif, null: false
      t.string :email, null: false
      t.string :website
      t.string :billing_address
      t.float :phone, null: false

      t.timestamps
    end
  end
end
