require 'rails_helper'

RSpec.describe CustomizationChoice, type: :model do
  subject { create :customization_choice }
  let(:name) { "simple name" }

  # association tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:model_ref) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:customization_type) }
  it { should belong_to(:manufacturer) }
  it { should belong_to(:customization_type) }

  # instance integrity tests
  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end

  it "is valid without an valid extra cost, and it is set to 0" do
    choice = build(:customization_choice, extra_cost: nil)
    expect(choice).to be_valid
    expect(choice.extra_cost).to eq(0)
  end

  it "is valid without a valid stock, and it is set to 0" do
    choice = build(:customization_choice, stock: nil)
    expect(choice).to be_valid
    expect(choice.stock).to eq(0)
  end
end
