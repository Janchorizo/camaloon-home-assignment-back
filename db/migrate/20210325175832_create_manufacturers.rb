class CreateManufacturers < ActiveRecord::Migration[6.1]
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.string :cif
      t.string :email
      t.string :website
      t.string :billing_address
      t.float :phone

      t.timestamps
    end
  end
end
