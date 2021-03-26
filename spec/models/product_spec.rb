require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:name) { "simple name" }
  subject { create(:product) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end
end
