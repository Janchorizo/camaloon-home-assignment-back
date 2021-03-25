class CreateCustomizationChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :customization_choices do |t|
      t.string :name
      t.string :model_ref
      t.references :manufacturer, null: false, foreign_key: true
      t.string :description
      t.float :extra_cost
      t.float :stock
      t.references :customization_types, null: false, foreign_key: true

      t.timestamps
    end
  end
end
