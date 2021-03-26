require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  subject { create :manufacturer }
  let(:name) { "simple name" }

  it "is valid with the factory parameters" do
    expect(subject).to be_valid
  end
end
