class Product < ApplicationRecord
  belongs_to :product_type
  has_many :product_choice_line

  validates_presence_of :product_type
  validates :name, :description, presence: true, length: { minimum: 1 }
  validates_inclusion_of :hidden, in: [true, false]
  validates :base_price, :presence => true, :numericality => {:greater_than => -1}

  validates_uniqueness_of :name

  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  def set_defaults
    if self.has_attribute?(:hidden) && self.hidden.nil?
      self.hidden = true
    end
    if self.has_attribute?(:base_price)
      self.base_price ||= 0.0
    end
  end
end
