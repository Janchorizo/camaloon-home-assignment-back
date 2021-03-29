FactoryBot.define do
    sequence :productTypeName do |n|
        "product_type_#{n}"
    end

    factory :product_type do
        name { generate(:productTypeName) }
        description { Faker::Coffee.notes }
        hidden { true }
    end
end