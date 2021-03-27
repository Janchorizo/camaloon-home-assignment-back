class ProductChoiceLine < ApplicationRecord
  belongs_to :customization_choice
  belongs_to :product

  validates_presence_of :customization_choice
  validates_presence_of :product
end
