class ProductChoiceLine < ApplicationRecord
  belongs_to :customization_choice
  belongs_to :product
end
