class Manufacturer < ApplicationRecord
    has_many :customization_choice, dependent: :destroy
end
