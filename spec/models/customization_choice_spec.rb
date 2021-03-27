require 'rails_helper'

RSpec.describe CustomizationChoice, type: :model do
  subject { create :customization_choice }
  let(:name) { "simple name" }

  # association tests
  it { should belong_to(:manufacturer) }
  it { should belong_to(:customization_type) }

  # instance integrity tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:model_ref) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:customization_type) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end

  it "is valid without an valid extra cost, and it is set to 0" do
    # factory build method can't be used as it will set the
    # extra cost after initialization, thus the default values
    # will not be set when checking the result instance
    # choice = build(:customization_choice, extra_cost: nil)
    manufacturer = create(:manufacturer)
    customization_type = create(:customization_type)
    choice = CustomizationChoice.new(
      name: 'sdf',
      model_ref: 'asdasd',
      description: 'asdasd',
      stock: 0,
      manufacturer: manufacturer,
      customization_type: customization_type
    )
    expect(choice).to be_valid
    expect(choice.extra_cost).to eq(0)
  end

  it "is valid without a valid stock, and it is set to 0" do
    manufacturer = create(:manufacturer)
    customization_type = create(:customization_type)
    choice = CustomizationChoice.new(
      name: 'sdf',
      model_ref: 'asdasd',
      description: 'asdasd',
      extra_cost: 0,
      manufacturer: manufacturer,
      customization_type: customization_type
    )
    expect(choice).to be_valid
    expect(choice.extra_cost).to eq(0)
  end
end
