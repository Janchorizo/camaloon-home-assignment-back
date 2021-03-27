class CreateCustomizationChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :customization_choices do |t|
      t.string :name, null: false
      t.string :model_ref, null: false
      t.string :description, null: false
      t.float :extra_cost, null: false
      t.float :stock, null: false
      t.belongs_to :manufacturer,  null: false, foreign_key: true
      t.belongs_to :customization_type,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
