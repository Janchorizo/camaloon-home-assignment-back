class CreateCustomizationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :customization_types do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.belongs_to :product_type,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
