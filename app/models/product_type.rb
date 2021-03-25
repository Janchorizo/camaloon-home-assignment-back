class ProductType < ApplicationRecord
    validates :name, :description, presence: true, length: { minimum: 1 }
    validates :hidden, presence: true, inclusion: [true, false]
    after_initialize :set_defaults, unless: :persisted?
    # The set_defaults will only work if the object is new

    def set_defaults
        self.hidden = true if self.hidden.nil?
    end
end
