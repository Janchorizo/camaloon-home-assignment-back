class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :product_types, null: false, foreign_key: true
      t.float :base_price
      t.boolean :hidden

      t.timestamps
    end
  end
end
