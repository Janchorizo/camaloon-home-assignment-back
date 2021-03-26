require 'rails_helper'

RSpec.describe CustomizationType, type: :model do
  subject { create :customization_type }
  let(:name) { "simple name" }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end

  it "is not valid without a valid name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a valid description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a product type" do
    subject.product_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a valid product type" do
    p_type = create :product_type
    subject.product_type_id = p_type.id + 5.0 # a non-existing id
    expect(subject).to_not be_valid
  end
end
