class CustomizationChoice < ApplicationRecord
  belongs_to :customization_type
  belongs_to :manufacturer
  has_many :product_choice_line

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :model_ref
  validates_presence_of :manufacturer
  validates_presence_of :customization_type
  validates :extra_cost, :presence => true, :numericality => true
  validates :stock, :presence => true, :numericality => {:greater_than => -1}

  after_initialize :set_defaults
  # The set_defaults will only work if the object is new

  def set_defaults
    if self.has_attribute?(:extra_cost)
      self.extra_cost ||= 0.0
    end
    if self.has_attribute?(:stock)
      self.stock ||= 0.0
    end
  end
end
