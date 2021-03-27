require 'rails_helper'

RSpec.describe ProductType, type: :model do
  subject { create :product_type }
  let(:name) { "simple name" }

  # instance integrity tests
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:description) }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end
  it "is is valid with valid attributes" do
    name = 'name'
    desc = 'desc'
    hidden = true
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to be_valid
  end
  it "is not valid without a name" do
    desc = 'desc'
    hidden = true
    p_type = ProductType.new(description: desc, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is not valid with a nil name" do
    name = nil
    desc = 'desc'
    hidden = true
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is not valid with an empty name" do
    name = ''
    desc = 'desc'
    hidden = true
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is not valid with a repeated name" do
    product_type = create(:product_type, name: :name)
    subject.name = :name
    expect(subject).to_not be_valid
  end
  it "is not valid without a description" do
    name = 'name'
    hidden = true
    p_type = ProductType.new(name: name, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is not valid with a nil description" do
    name = 'name'
    desc = nil
    hidden = true
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is not valid with an empty description" do
    name = 'name'
    desc = ''
    hidden = true
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to_not be_valid
  end
  it "is valid with a nil or invalid hidden parameter, and it is set to true" do
    name = 'name'
    desc = 'desc'
    hidden = nil
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to be_valid
    expect(p_type.hidden).to eq(true)

    hidden = 'text'
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to be_valid
    expect(p_type.hidden).to eq(true)

    hidden = 123
    p_type = ProductType.new(name: name, description: desc, hidden: hidden)
    expect(p_type).to be_valid
    expect(p_type.hidden).to eq(true)
  end
  it "is valid with an empty hidden paramter, and it is set to true" do
    name = 'name'
    desc = 'desc'
    p_type = ProductType.new(name: name, description: desc)
    expect(p_type).to be_valid
    expect(p_type.hidden).to eq(true)
  end
end
