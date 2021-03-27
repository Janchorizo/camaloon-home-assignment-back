class Manufacturer < ApplicationRecord
    has_many :customization_choice, dependent: :destroy

    validates_presence_of :name
    validates_presence_of :cif
    validates_presence_of :phone
    validates_presence_of :email

    validates_length_of :name, :minimum => 1
    validates_length_of :cif, :minimum => 1

    validates_uniqueness_of :name
    validates_uniqueness_of :cif
end
