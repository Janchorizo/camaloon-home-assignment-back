class CustomizationType < ApplicationRecord
    belongs_to :product_type
    has_many :customization_choice, dependent: :destroy

    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :product_type

    validates_length_of :name, :minimum => 1
    validates_length_of :description, :minimum => 1

    validates_uniqueness_of :name
end
