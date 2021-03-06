class ProductType < ApplicationRecord
    has_many :product, dependent: :destroy
    has_many :customization_type, dependent: :destroy
    
    validates :name, :description, presence: true, length: { minimum: 1 }
    validates_inclusion_of :hidden, in: [true, false]

    validates_uniqueness_of :name


    after_initialize :set_defaults, unless: :persisted?
    # The set_defaults will only work if the object is new

    def set_defaults
        self.hidden = true if self.hidden.nil?
    end
end
