require 'rails_helper'

RSpec.describe CustomizationType, type: :model do
  subject { create :customization_type }
  let(:name) { "simple name" }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end
end
