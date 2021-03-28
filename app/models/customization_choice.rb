class CustomizationChoice < ApplicationRecord
  belongs_to :customization_type
  belongs_to :manufacturer

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :model_ref
  validates_presence_of :manufacturer
  validates_presence_of :customization_type
  validates :extra_cost, :numericality => true
  validates :stock, :presence => true, :numericality => {:greater_than => -1}

  after_initialize :set_defaults
  # The set_defaults will only work if the object is new

  def set_defaults
    self.extra_cost ||= 0.0
    self.stock ||= 0.0
  end
end
