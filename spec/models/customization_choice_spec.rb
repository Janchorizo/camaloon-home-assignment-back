require 'rails_helper'

RSpec.describe CustomizationChoice, type: :model do
  #subject { create :customization_choice }
  let(:name) { "simple name" }

  it "is valid with the factory parameters" do
    c = create :customization_choice
    expect(c).to be_valid
  end
end
