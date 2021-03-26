require 'rails_helper'

RSpec.describe ProductChoiceLine, type: :model do
  subject { create :product_choice_line }
  let(:name) { "simple name" }

  it { should validate_presence_of(:customization_choice) }
  it { should validate_presence_of(:product) }
  it { should belong_to(:customization_choice) }
  it { should belong_to(:product) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end
end
