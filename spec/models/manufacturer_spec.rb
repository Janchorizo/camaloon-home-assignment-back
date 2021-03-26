require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  subject { create :manufacturer }
  let(:name) { "simple name" }

  # instance integrity tests
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:cif) }
  it { should validate_uniqueness_of(:cif) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end

  it "is not valid with a repeated name" do
    manufacturer = create(manufacturer, name: :name)
    subject.name = :name
    expect(subject).to_not be_valid
  end

  it "is not valid with a repeated cif" do
    manufacturer = create(manufacturer, cif: :cif)
    subject.cif = :cif
    expect(subject).to_not be_valid
  end

  it "is valid without a valid website" do
    subject.website = nil
    expect(subject).to be_valid
  end

  it "is valid without a valid billing address" do
    subject.billing_address = nil
    expect(subject).to be_valid
  end
end
