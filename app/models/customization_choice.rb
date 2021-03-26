class CustomizationChoice < ApplicationRecord
  belongs_to :customization_type
  belongs_to :manufacturer
end
