class CreateProductTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_types do |t|
      t.string :name,  null: false
      t.string :description,  null: false
      t.boolean :hidden,  null: false

      t.timestamps
    end
  end
end
