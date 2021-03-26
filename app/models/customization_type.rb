class CustomizationType < ApplicationRecord
    belongs_to :product_type
    has_many :customization_choice, dependent: :destroy
end
