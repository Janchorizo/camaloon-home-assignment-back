class CustomizationChoice < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :customization_types
end
