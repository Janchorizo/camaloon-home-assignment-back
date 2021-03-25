class CreateProductChoiceLines < ActiveRecord::Migration[6.1]
  def change
    create_table :product_choice_lines do |t|
      t.references :customization_choices, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
