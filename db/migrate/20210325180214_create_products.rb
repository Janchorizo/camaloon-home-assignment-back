class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.float :base_price, null: false
      t.boolean :hidden, null: false
      t.belongs_to :product_type,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
