require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:name) { "simple name" }
  subject { create(:product) }

  # association tests
  it { should belong_to(:product_type) }

  # instance integrity tests
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:product_type) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end

  it "is not valid with an empty name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it "is not valid with an empty description" do
    subject.description = ''
    expect(subject).to_not be_valid
  end

  it "is valid with a nil or invalid hidden parameter, and it is set to true" do
    p = build(:product, hidden: nil)
    expect(p).to be_valid
    expect(p.hidden).to eq(true)

    p = build(:product, hidden: 'text')
    expect(p).to be_valid
    expect(p.hidden).to eq(true)

    p = build(:product, hidden: 123)
    expect(p).to be_valid
    expect(p.hidden).to eq(true)
  end

  it "is valid with a nil or invalid base_price parameter, and it is set to 0" do
    p = build(:product, base_price: nil)
    expect(p).to be_valid
    expect(p.hidden).to eq(0)

    p = build(:product, base_price: 'text')
    expect(p).to be_valid
    expect(p.hidden).to eq(0)
  end
end