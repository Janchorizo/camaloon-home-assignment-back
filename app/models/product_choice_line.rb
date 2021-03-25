class ProductChoiceLine < ApplicationRecord
  belongs_to :customization_choices
  belongs_to :products
end
